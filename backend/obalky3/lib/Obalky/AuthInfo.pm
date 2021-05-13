
package Obalky::AuthInfo;

use Data::Dumper;
use HTML::Tiny;

use Obalky::Config;

=head1 NAME

Obalky::AuthInfo - zpracovani identifikatoru autority

=head1 SYNOPSIS

	use Obalky::AuthInfo

=head1 DESCRIPTION

Jako identifikator pouzijte ID autority z autoritni baze NKP CZ.

=cut


my @keys = qw/auth_id/;

sub param_keys { qw/auth_id/ }

sub new {
	my($pkg,$object) = @_;
	my $authinfo = bless {}, $pkg;
	return $authinfo unless(defined $object);
	
	$authinfo->{auth_id} = $object->id;
	$authinfo->{auth_name} = $object->auth_name;
	$authinfo->{auth_date} = $object->auth_date;

	return $authinfo;
}

sub merge {
	my($old,$new) = @_;
	my $changes = 0;
	foreach my $key (@keys) {
		if(defined $new->{$key} and not defined $old->{$key}) {
			$old->{$key} = $new->{$key};
			$changes++;
		}
	}
	return $changes;
}

=item C<is_same>

Porovna dva authinfo objekty, vrati undef, kdyz neumi rozhodnout, zda jsou stejne

=cut
sub differs {
	my($a,$b) = @_;
	return $a->auth_id ne $b->auth_id if($a->auth_id and $b->auth_id);
	return undef; # nevime..
}

sub set_id {
	my($auth_id,$value) = @_;
	$auth_id->{auth_id} = $value if(defined $value);
	return $auth_id->{auth_id};
}

sub new_from_id {
	my($pkg,$auth_id) = @_;
	return $pkg->new_from_params({ auth_id => $auth_id});
}

sub new_from_params {
	my($pkg,$param) = @_;
	$param = $param->[0] if(ref $param eq 'ARRAY');
	my $auth_id = $param->{auth_id};
	
	return unless($auth_id); 
	
	return bless {
		auth_id => $auth_id
	}, $pkg;
}

sub save_to {
	my($auth,$object) = @_;
	warn "Updating ".$object->id." with ".Dumper($auth->save_to_hash())
						if($ENV{DEBUG} and $ENV{DEBUG} > 2);
	my $hash = $auth->save_to_hash();
	$object->update($hash);
}

sub save_to_hash {
	my($authinfo,$hash) = @_;
	$hash ||= {};
	map $hash->{$_} = $auth->{$_}, grep $auth->{$_}, qw/auth_id/;
	
	return $hash;
}

sub to_params {
	my($auth) = @_;
	my @out;
	foreach(qw/auth_id/) {
		push @out, $_."=".$auth->{$_} if($auth->{$_});
	}
	return join("&",@out);
}

sub get_obalkyknih_url {
	my($authinfo,$secure) = @_;
	return Obalky::Config->url($secure)."/view?auth=".$authinfo->{auth_id};
}

sub get_fullname{
	$self = shift;
	
	"a" =~ /a/; #reset regex capture
	$fullName = $self->{auth_name};
	$fullName =~ '(.*?), ([^,]*)|([^,]*),?';
	my $givenName;
	my $surname;
	
	if ($1) {
		$givenName = $2;
		$surname = $1;
	} else {
		$givenName = $3;
		$surname = '';
	}
	
	return $givenName . ' ' . $surname;
}


=back 

=head1 AUTHOR

Cosmotron Bohemia s.r.o. - L<mailto:orsag@cosmotron.cz>

=cut

1;
