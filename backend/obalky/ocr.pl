#!/usr/bin/perl -w

use SOAP::Lite;# +trace => 

my $x = SOAP::Lite
      -> uri('http://195.113.155.161/Recognition3WS/RSSoapService.asmx')
		->service('file:///opt/obalky/ocr.wsdl')
#		           ->on_debug( sub { print @_; } )
			->DoNothingMethod();
#			->GetWorkflows(serverLocation => '195.113.155.161');

print Dumper($x);

;#			      -> result;

__END__
use SOAP::WSDL;
use Data::Dumper;

my $soap = SOAP::WSDL->new(wsdl => 'file:///opt/obalky/ocr.wsdl', no_dispatch=>1);

my %data = ( serverLocation => '195.113.155.161' );
my $result = $soap->call('GetWorkflows', %data);
print Dumper($result);

