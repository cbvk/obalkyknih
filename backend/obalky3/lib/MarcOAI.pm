package MarcOAI;

=head1 NAME

MarcOAI

=cut

use base qw( XML::SAX::Base );
use Data::Dumper;
use MARC::Record;
use MARC::Field;
use utf8;

=head1 EXAMPLE

my $harvester = Net::OAI::Harvester->new( 
        'baseURL' => 'http://aleph.nkp.cz/OAI'
);

my $records = $harvester->listRecords(
        'metadataPrefix'  => 'marc21',
        'set'             => 'AUT',
        'from'            => '2015-11-01T00:00:00Z',
        'until'           => '2015-11-01T23:59:59Z',
        'metadataHandler' => 'MarcOAI'
);

while ( my $record = $records->next() ) {
        my $header = $record->header();
        my $metadata = $record->metadata();
        print "identifier: ", $header->identifier(), "\n";
        warn Dumper($metadata->pretty());
}

=cut

my @stack; # MARC XML zasobnik
my $metadata_start = 0;
my $datestamp = '';


sub new {
        my $marc = MARC::Record->new();
        my $self = {
                marc => $marc
        };
        return( bless $self, 'MarcOAI' );
}

sub start_element {
        my ($self,$element) = @_;
        
        my $name = $element->{LocalName};
        $datestamp = '#' if ($name eq 'datestamp');
        
        my ($tag,$ind1,$ind2) = (undef,' ', ' ');
        
        # zacina ridici pole
        if ($name eq 'leader') {
        	push @stack, { 'name' => $name };
        }
        
        # zacina ridici pole
        if ($name eq 'controlfield') {
                $tag = $element->{Attributes}->{'{}tag'}->{Value};
                push @stack, { 'name' => $name, 'tag' => $tag };
        }
        
        # zacina datove pole
        if ($name eq 'datafield') {
                $tag = $element->{Attributes}->{'{}tag'}->{Value};
                $ind1 = $element->{Attributes}->{'{}ind1'}->{Value};
                $ind2 = $element->{Attributes}->{'{}ind2'}->{Value};
                $ind1 = ' ' unless($ind1);
                $ind2 = ' ' unless($ind2);
                push @stack, { 'name' => $name, 'tag' => $tag, 'ind1' => $ind1, 'ind2' => $ind2 };
        }
        
        # zacina pod pole
        if ($name eq 'subfield') {
                $subtag = $element->{Attributes}->{'{}code'}->{Value};
                push @stack, { 'name' => $name, 'subtag' => $subtag };
        }
}

sub end_element {
        my ($self, $element) = @_;
        
        my $name = $element->{LocalName};
        
        # zacinaji MARC XML data
        if ($name eq 'leader') {
                $metadata_start = 1;
                my $el = pop @stack;
                $self->{'marc'}->leader($el->{'val'});
        }
        
        return unless ($metadata_start);
        
        if ($name eq 'controlfield') {
        	my $el = pop @stack;
        	my $field = MARC::Field->new($el->{'tag'}, $el->{'val'});
    		$self->{'marc'}->append_fields($field);
        }
        
        if ($name eq 'datafield') {
        	# subtags
        	my %subf;
        	my $el;
        	while (scalar @stack) {
        		$el = pop @stack;
        		last if ($el->{'name'} eq 'datafield'); # toto uz je tag
        		if (defined $subf{$el->{'subtag'}}) {
        			$subf{$el->{'subtag'}} = $el->{'val'} . ', ' . $subf{$el->{'subtag'}};
        		} else {
        			$subf{$el->{'subtag'}} = $el->{'val'};
        		}
        	}
        	# tag
        	my $field = MARC::Field->new($el->{'tag'}, $el->{'ind1'}, $el->{'ind2'}, %subf);
        	$self->{'marc'}->append_fields($field);
        }
}

sub characters {
        my ($self, $chars) = @_;
        my $el = pop @stack;
        unless (defined $el->{'val'}) {
        	$el->{'val'} = $chars->{'Data'};
        } else {
        	$el->{'val'} = $el->{'val'} . $chars->{'Data'};
        }
        push @stack, $el;
}

1;