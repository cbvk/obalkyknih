
package DB::ResultSet::Cache;
use base 'DBIx::Class::ResultSet';

use Obalky::Tools;

use Carp;

use DateTime;
use JSON;

use strict;
use warnings;

sub canonize {
	my($self,$obj) = @_;
	return JSON->new->canonical(1)->encode($obj);
}

sub load {
	my($self,$key) = @_;
	my($row) = $self->search({ "request" => $key });
	return unless($row);
		# if($row->created);
	return ($row->bookid,JSON->new->decode($row->response)); 
}

sub store {
	my($self,$key,$bookid,$value) = @_;
	warn "CACHE $bookid: $key: value=$value" unless(ref $value);
	my $response = JSON->new->canonical(1)->encode($value);
	warn "Storing $key as $response\n";
	$self->create({ request => $key, bookid => $bookid, response => $response });
}

sub invalidate {
	my($self,$bookid) = @_;
	$bookid = $bookid->id if(ref $bookid); # podporujem i tohle..
	$self->search({ bookid => $bookid })->delete if($bookid);
}

1;
