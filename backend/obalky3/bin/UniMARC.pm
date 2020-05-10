
package UniMARC;

use base qw( XML::SAX::Base );

sub new { 
	# fix: nefunguje, pokud bychom cetli jinsi podpole nez prvni..
	return bless { tag => '', code => '', x00 => '',
				   id => '', isbn => '', url => '' }, shift;
}

    ## SAX Methods

sub start_element {
	my($self,$element) = @_;

   	$self->{tag} = $element->{Attributes}->{'{}tag'}->{Value}
		if($element->{Name} =~ /^(data|control)field$/i);

#  	$self->{subf} = $element->{Attributes}->{'{}code'}->{Value}
#		if($element->{Name} =~ /^subfield$/i);

	my $code = $element->{Attributes}->{'{}code'};
	$self->{code} = $code->{Value} if($code and $code->{Value});
}
      
sub end_element {
	my($self,$element) = @_;
	$self->{code} = ''; 
	$self->{tag} = '' if($element->{Name} =~ /^(data|control)field$/i);
}

sub characters {
	my($self,$chars) = @_;
	$self->{id} .= $chars->{Data} if($self->{tag} eq '001');
	$self->{url} .= $chars->{Data} 
		if($self->{tag} =~ /^X0./i and $self->{code} eq 'o');
	$self->{x00} .= $chars->{Data}." " if($self->{tag} =~ /^X0./i);
	$self->{isbn} .= $chars->{Data} 
		if($self->{tag} eq '010' and $self->{code} eq 'a');
}

1;
