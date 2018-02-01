
package Obalky::Controller::API;

use strict;
use warnings;
use base 'Catalyst::Controller';

use Digest::SHA1  qw(sha1_hex);
use Date::Simple ('date', 'today');
use DateTime::Format::ISO8601;
use Data::Dumper;
use Encode;
use JSON;

use Obalky::Tools;

# take v Tools.pm
my $OCR_DIR_INPUT  = "/opt/obalky/ocr/input";
#my $CONVERT_BIN = "/opt/obalky/tool/graphicsmagick/bin/gm convert";
my $CONVERT_BIN = "/usr/bin/gm convert";

sub tocxml : Local {
	my($self,$c) = @_;
	$c->response->content_type("application/xml;charset=UTF-8");
	$c->response->headers->header('Content-disposition',
					"attachment;filename=toc-".today().".xml");
	binmode(STDOUT,"utf8"); # fakt skaredy hack.. :-(
	# 
	$c->response->print('<?xml version="1.0" encoding="utf-8" ?>'."\n");
	$c->response->print("<obalkyknih>\n");
	my $tocs = DB->resultset('Toc')->search;
	while(my $toc = $tocs->next) {
		$c->response->print($toc->to_xml);
	}
	$c->response->print("</obalkyknih>\n");
}

sub update : Local {
	my($self,$c) = @_;
	$c->response->content_type("text/plain;charset=UTF-8");
	$c->response->body("OK...");
}

sub sync : Local {
	my($self,$c) = @_;
	DB->resultset('Eshop')->sync_eshops();
	$c->response->content_type("text/plain;charset=UTF-8");
	$c->response->body("OK...");
}

sub add_review : Local {
	my($self,$c) = @_;
	
	# parametry: rating, visitor_name, html_text!
	my $rating = $c->req->param("rating") || undef;
	$rating *= 10 if ($rating && $rating<10);
	my $html_text = $c->req->param("html_text") || "";
	my $id = $c->req->param("id") || undef;
	my $book_id = $c->req->param("book_id") || undef;
	my $sigla = $c->req->param("sigla") || "";
	# pokud neni ani rating and html_text neni co hodnotit
	return if (!$rating && $html_text eq "");

	my ($library,$session,$visitor) = Obalky->visit($c);
	if ($c->req->param("sigla")) {
		#pozadavek z frontendu (APIv3.0) - pouze frontend server muze ukladat komentare timto zpusobem
		$library = DB->resultset('Library')->search({ code=>$c->req->param("sigla") })->next;
		my $fe = DB->resultset('FeList')->search({ ip_addr=>$c->request->address });
		return unless($fe->count || $c->request->address eq '127.0.0.1');
	}

	my($this,$bibinfo) = (undef,undef);
	if ($book_id) {
		my $book = DB->resultset('Book')->find($book_id);
		$bibinfo = Obalky::BibInfo->new($book);
	} else {
		$this = from_json($c->req->param("book"));
		$bibinfo = Obalky::BibInfo->new_from_params($this->{bibinfo});
	}

	return unless($library and $bibinfo);

	my $book = DB->resultset('Book')->find_by_bibinfo($bibinfo);

	# existuje uz zaznam v tabulce review ?
	# pokud ano, v dalsich krocich bude se pokracovat editaci
	my $flagEdit = 0;
	my $retExists;
	if ($id && $library) {
		$retExists = DB->resultset('Review')->search({ library=>$library->id, library_id_review=>$id });
		$flagEdit = $retExists->count;
	}

	my $review_params = {
		id => $id,
		rating => $rating,
		html_text => $html_text,
		visitor => $visitor,
		visitor_name => $visitor->name, # asi nevyplneno...
		visitor_ip => $c->request->address,
		sigla => $sigla,
		impact => $html_text ne "" ? $Obalky::Media::REVIEW_COMMENT : $Obalky::Media::REVIEW_VOTE
	};

	unless ($flagEdit) {
		# zaznam komentare neexistuje, vytvarime
		$book->add_review($library,$visitor,$review_params);
	} else {
		# zaznam komentare existuje, editujeme
		$retExists = $retExists->next;
		$book = $retExists->book;
		$book->edit_review($retExists,$library,$visitor,$review_params);
	}

	$book->enrich($this,$library,$bibinfo,$c->request->secure);
	
	# vyvolej promazani metadat ze vsech frontend serveru
	DB->resultset('FeSync')->request_sync_review($book,$c->request->secure);

	$c->response->content_type("text/javascript;charset=UTF-8");
#	$c->response->content_encoding("UTF-8");
	$c->response->body("obalky.callback(".to_json([$this]).");\n");
}

sub del_review : Local {
	my($self,$c) = @_;
	
	# parametry: id a sigla!
	my $id = $c->req->param("id") || undef;
	my $sigla = $c->req->param("sigla") || "";
	# pokud neni ani id ani sigla neni co mazat
	return if (!$id && $sigla eq "");

	my ($library,$session,$visitor) = Obalky->visit($c);
	if ($sigla ne "") {
		#pozadavek z frontendu (APIv3.0) - pouze frontend server muze ukladat komentare timto zpusobem
		$library = DB->resultset('Library')->search({ code=>$c->req->param("sigla") })->next;
		my $fe = DB->resultset('FeList')->search({ ip_addr=>$c->request->address });
		return unless($fe->count || $c->request->address eq '127.0.0.1');
	}

	my($this,$bibinfo,$book,$book_id) = (undef,undef,undef,undef);
	my $review = DB->resultset('Review')->search({ library=>$library->id, library_id_review=>$id })->next;
	$book_id = $review->book->id if ($review);
	if ($book_id) {
		$book = DB->resultset('Book')->find($book_id);
		$bibinfo = Obalky::BibInfo->new($book);
		$this->{ean} = $book->ean13 if $book->ean13;
		$this->{nbn}  = $book->nbn if $book->nbn;
		$this->{oclc} = $book->oclc if $book->oclc;
	} else {
		return;
	}

	return unless($library and $bibinfo);

	my $review_params = {
		id => $id,
		sigla => $sigla
	};

	# zaznam komentare neexistuje, vytvarime
	$book->del_review($review,$library,$visitor,$review_params);

	$book->enrich($this,$library,$bibinfo,$c->request->secure);
	
	# vyvolej promazani metadat ze vsech frontend serveru
	DB->resultset('FeSync')->request_sync_review($book,$c->request->secure);

	$c->response->content_type("text/javascript;charset=UTF-8");
	$c->response->body("obalky.callback(".to_json([$this]).");\n");
}

sub do_book_request {
	my($self,$c,$session,$library,$visitor,$this) = @_;

	my $bibinfo = Obalky::BibInfo->new_from_params($this->{bibinfo});

	# v dotazu chybi minimalni udaje, ignoruj..
	return unless($library and $bibinfo);
	
	# normalizace identifikatoru casti
	$bibinfo = DB->resultset('Book')->normalize_bibinfo($bibinfo) if ($bibinfo->{part_no} or $bibinfo->{part_name});
	
    my $book = DB->resultset('Book')->find_by_bibinfo($bibinfo);
    
	# pokud se zaznam nenasel, a neni vytvoren novy (napr. v pripade dotazu na periodikum, nebo vicesvazkovou monografii)
	# vratime souborny zaznam - jeho part_most_recent
	unless ($book) {
		my $dummy;
		my $book_bibinfo = $this->{bibinfo};
		# identifikatory hledaneho zaznamu
		$dummy->{bibinfo} = $book_bibinfo;
		foreach(qw/isbn nbn oclc part_year part_volume part_no part_name part_note/) {
			my $key = ($_ eq 'isbn') ? 'ean' : $_;
			$dummy->{$key}=$book_bibinfo->{$_} if ($book_bibinfo->{$_});
		}
		# pokus o dohledani souborneho zaznamu
		my $parent_bibinfo;
		foreach(qw/isbn nbn oclc/) {
			my $key = ($_ eq 'isbn') ? 'ean13' : $_;
			$parent_bibinfo->{$key}=$book_bibinfo->{$_} if ($book_bibinfo->{$_});
		}
		my $book_parent = DB->resultset('Book')->find_by_bibinfo($parent_bibinfo);
		$dummy->{book_id_parent}=$book_parent->id if ($book_parent);
		
		$dummy->{flag_bare_record}=1;
		return (undef, $dummy);
	}

	$book->enrich($this,$library,$bibinfo,$c->request->secure,$c->req->params);
	
	# pokud skutecna cast monografie, nebo periodika neexistuje,
	# potrebujeme tento zaznam zmenit na dummy = identifikatory casti nahradit za ty, ktere byly v pozadavku
	unless ($book) {
		$this->{part_no} = $bibinfo->{part_no} if ($bibinfo->{part_no});
		$this->{part_name} = $bibinfo->{part_name} if ($bibinfo->{part_name});
		$this->{part_year} = $bibinfo->{part_year} if ($bibinfo->{part_year});
		$this->{part_volume} = $bibinfo->{part_volume} if ($bibinfo->{part_volume});
		$this->{flag_bare_record} = 1;
	}

	# jen docasne - zkratime debug vypisy..
	# delete $this->{bibinfo} if($this); 
	return ($book->id,$this);
}

sub do_books_request {
	my($self,$c,$books,$tip) = @_;

	# parametrizovatelne, co se po nas vlastne chce?
	# nebo cachovat vystup a priste ho nepropocitavat?

	DB->resultset('Eshop')->sync_eshops();

	my($library,$session,$visitor) = Obalky->visit($c);

	my @book;
	foreach my $this (ref $books eq 'ARRAY' ? @$books : []) {
	#	my $key = DB->resultset('Cache')->canonize($this);
	#	my($bookid,$full) = DB->resultset('Cache')->load($key);
	#	unless($full) {
	#		($bookid,$full) = $self->do_book_request($c,$session,
	#									$library,$visitor,$this);
	#		DB->resultset('Cache')->store($key,$bookid,$full);
	#	}
		$this = pop @{$this} if (ref $this eq 'ARRAY');
		my($bookid,$full) = $self->do_book_request($c,$session,
									$library,$visitor,$this);
		push @book, $full if(defined $full);
	}

	$c->response->content_type("text/javascript;charset=UTF-8");
	$c->response->body("obalky.callback(".to_json(\@book).");\n");
}

sub book : Local {
	my($self,$c) = @_;
	my $book = from_json($c->req->param("book"));
	$self->do_books_request($c,[$book],1);
}

sub books : Local {
	my($self,$c) = @_;
	my $books = eval { from_json($c->req->param("books")) };
	$books = [$books] if(ref $books eq 'HASH');
	$books = [] unless $books; 
	# trochu hack.. pokud je dotaz jen na jednu, pak je to plne zobrazeni
	$self->do_books_request($c,$books,(scalar(@$books) == 1));
}


sub list : Local {
	my($self,$c) = @_;
	my $from  = DateTime::Format::ISO8601->parse_datetime(
					$c->req->param('from'));
	my $until = DateTime::Format::ISO8601->parse_datetime(
					$c->req->param('until'));
	unless($from and $until) {
		$c->response->status(400); # Bad Request
		# "The client SHOULD NOT repeat the request without modifications."
		$c->response->content_type("text/plain");
	    $c->response->body("from/until: Malformed syntax\n");
	} else {
		# fix: format=(plain|xml|json) ?
		my @list = DB->resultset('Cover')->created_in_range($from,$until);	
		$c->response->content_type("text/plain");
	    $c->response->body(join("",map $_->id."\n", @list));
	}
}

sub queue : Local {
    my($self,$c) = @_;
	die "api/queue: Not implemented in this version! Contact martin\@sarfy.cz";
}

my $last_time = 0;
my $last_count = 0;
my $last_warn = 0;

sub file : Private {
    my($self,$method,$c,$visitor,$library) = @_;

	# pocitej pocet thumbnail dotazu v aktualni sekunde (last_time, last_count)
	# obvykle je tak kolem 10-ti
	if($method eq 'thumbnail') {
		my $time_now = time;
		if($time_now != $last_time) {
			$last_time = $time_now;
#			warn "$$ $last_time -> $last_count\n";
			$last_count = 0;
		}
		if($last_count++ > 20) {
			if(($time_now - $last_warn < 600) or (($last_warn - $time_now) % 600) == 0) {
				warn "$$ $last_time -> $last_count thumbnails per second, disabling..\n";
				$last_warn = $time_now;
			}
			# img/js/js_callbck/xml
			$c->response->status(404); # Not found
			return;
		}
	}

	my $format = $c->req->param('format') || '';
	my $bibinfo = Obalky::BibInfo->new_from_params($c->req->params,
					$library ? $library->code : undef);
	my $return = lc($c->req->param('return') || 'img'); # default bude js!!
	my $client_ip = $c->req->address;

	my $request = { # create hash with request params..
		method  => $method, library => $library, format => $format,
		client_ip => $client_ip, visitor_id => 
			($visitor ? $visitor->id : undef) , returning => $return
	};

	my $cover; # budeme hledat vhodnou obalku
	my $result;

	unless($cover) { # primo id obalky
		$cover = DB->resultset('Cover')->retrieve($c->req->param('id'))
					if($c->req->param('id'));
		$result = "found" if($cover); # or "direct"?
	}

	unless($cover) { # najdi dle identifikatoru
	    my $book = DB->resultset('Book')->find_by_bibinfo($bibinfo) 
						if($bibinfo);
		$cover = $book->cover if($book and $book->cover);
		$result = "found" if($cover);
	}

	$result = "spacer" unless($cover); # nic nenalezeno..
#	$result = "spacer" unless($library); # kostlivec..

	$cover->update({ used_count => $cover->used_count+1, 
					 used_last => DateTime->now() }) if($cover);

	$request->{result} = $result;
	$request->{cover} = $cover;
	$bibinfo->save_to_hash($request) if($bibinfo);
	DB->resultset('Request')->create($request) if($library);

	my $image = $cover->get_absolute_url( $method eq 'cover' 
		? 'medium' : 'thumbnail',$c->req->secure) if($cover);

	my $backlink = $bibinfo->get_obalkyknih_url 
						if($bibinfo and $method ne 'thumbnail');

	$c->response->header("Cache-Control"=>"max-age=600");

	if($return eq 'img') {
		my $default = $c->req->param('default');
		if($result eq 'spacer') {
			$c->response->redirect($default || ($c->req->secure ? 
	$Obalky::Config::SPACER_HTTPS_URL : $Obalky::Config::SPACER_HTTP_URL));
		}  else {
			$c->response->redirect($image); # kdyz neni image?
		}
	} elsif($return eq 'js') {
		$c->response->content_type("text/javascript");
		my $body = '';
		if($result eq 'found') {
			$body = "document.write(\"<div style=\\\"\\\">".
				($backlink?"<a href=\\\"$backlink\\\">":"").
				"<img src=\\\"$image\\\" alt=\\\"cover ".$cover->id."\\\" ".
				"border=\\\"0\\\"".
				($backlink?"></a>":"")."</div>\");\n";
		}
	    $c->response->body($body);

	} elsif($return eq 'js_callback') {
		$c->response->content_type("text/javascript");
		if($result eq 'found') {
		    $c->response->body($cover->js_callback(
				$c->req->param('callback'),$c->req->param('callback_arg')));
		}
	} elsif($return eq 'xml') {
		if($result eq 'found') {
			$c->response->content_type("application/xml");
			my $xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
					"<cover id=\"".$cover->id."\">\n".
					"\t<image_url>".$image."</image_url>\n";
			$xml .= "\t<backlink_url>".$backlink."</backlink_url>\n" 
							if($backlink);
			$xml .= "</cover>\n";
	    	$c->response->body($xml);
		} else {
			$c->response->status(404); # Not found
#			$c->response->content_type("text/plain");
#		    $c->response->body("Requested cover not found or not available\n");
		}
	}
}

sub cover : Local {
    my($self,$c) = @_;
	my($library,$session,$visitor) = Obalky->visit($c);
	return $self->file("cover",$c,$visitor,$library);
}

sub thumbnail : Local {
    my($self,$c) = @_;
	return $self->file("thumbnail",$c,undef,undef);
}


sub index : Local {
    my($self,$c) = @_;
    $c->response->body('Matched Obalky::Controller::Main in Main.');
}

sub end : Private {
    my($self,$c) = @_;
	return 0;
}

sub ocr : Local {
	my($self,$c) = @_;
	if($c->req->param('file')) {
		my $tmp = "/tmp/.ocr-$$-".int(rand(10000000)).".pdf";
		$self->_upload_file($c,"file",$tmp);
		system("/opt/obalky/ocr/run.sh $tmp $tmp.pdf");
		my $content = Obalky::Tools->slurp("$tmp.pdf");
		unlink $tmp, "$tmp.pdf";
		$c->response->content_type("application/pdf");
		$c->response->body($content);
	} else {
		$c->response->content_type("text/html");
		$c->response->body("<form method='post' enctype='multipart/form-data'".
				"><input type=file name=file><input type=submit></form>");
	}
}

# toto je nekde pouzivano?
sub upload : Local {
	my($self,$c) = @_;
	my $info;
	$info->{login} = $c->user ? $c->user->get('login') : '-';
	$info->{file}  = $c->req->upload('file');
	$info->{$_} = scalar($c->req->param($_)) 
		foreach(qw/license source backlink_url url/);

	my $bibinfo = Obalky::BibInfo->new_from_params($c->req->params);

	$c->response->content_type("text/plain");

	if($info->{url} or $info->{file}) {
		my $batch;
		eval { $batch = DB->resultset('Upload')->upload(
							$c->response,$bibinfo,$info) };
    	$c->response->body($@) if($@);
		return $@ ? $@ : 0;
    }
	return 0;
}

sub _now {
    my($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
	return sprintf("%04d-%02d-%02dT%02d:%02d:%02d",
				   $year+1900,$mon+1,$mday,$hour,$min,$sec);
}

# funkce by mela byt spis v /opt/obalky/lib/DB/ResultSet/Upload.pm
# zpracovani toc je podobne Eshop::Zbozi! 
sub import : Local {
	my($self,$c) = @_;

    eval { $self->_do_import($c) };

    $self->_do_log("IMPORT FAILED: $@") if($@);
}

sub _do_log {
    my($self,$msg) = @_;
   	open(LOG,">>utf8","/opt/obalky/log/import.log"); 
   	print LOG $self->_now." ".$msg."\n"; close(LOG);
}

sub _do_import {
	my($self,$c) = @_;

    $self->_do_log("import begin");
	warn Dumper($c->req->params) if ($ENV{DEBUG});
	# autentizuj uzivatelem, misto cookies staci user/password parametry
=asf
	unless($c->user) {
		# login, password a over.. $c->authenticate
		unless($c->authenticate({ login => $c->req->param('login'), 
								  password => $c->req->param('password') })) {
			$c->response->status(401);
			$c->response->body("Unauthorized");
			return;
		}
	}
	my $user = $c->user->login;
=cut
	my $user;



	# z parametru zkonstruuj identifikator knizky (TODO jen BibInfo->fields?)
	my $bibinfo_params = {};
	$bibinfo_params->{$_} = decode_utf8($c->req->param($_))
		foreach(Obalky::BibInfo->param_keys);
	# jen docasny fix
	$bibinfo_params->{authors} ||= decode_utf8($c->req->param('author'));
	my $bibinfo_aggr;
	my $part_type = $c->req->param('part_type');
	$part_type = "" unless ($part_type);
	# bibinfo souborneho zaznamu
	if ($part_type eq "serial" or $part_type eq "mono") {
		
		# chybi povinny parametr
		unless ($c->req->param("part_no") or $c->req->param("part_name") or ($c->req->param("part_year") or $c->req->param("part_volume"))) {
			$c->response->content_type("text/plain");
			$c->response->body("Missing params part_year, or part_volume, part_no, or part_name.");
			return;
		}
		
 
		my $bibinfo_aggr = Obalky::BibInfo->new_from_params($bibinfo_params);

 		my @other_part_eans;
		if ($c->req->param('part_other_isbn') && $bibinfo_aggr->{ean13}){
			@other_part_eans = split(',', $c->req->param('part_other_isbn'));
			@other_part_eans = map {Obalky::BibInfo->parse_code($_)} @other_part_eans;	
		}
		my $book_aggr = DB->resultset('Book')->find_by_bibinfo($bibinfo_aggr);
		
		# spracovani vicero ISBN
		if (!$book_aggr and @other_part_eans) {
			foreach (@other_part_eans){
				($_, $bibinfo_aggr->{ean13}) = ($bibinfo_aggr->{ean13}, $_);
				$book_aggr = DB->resultset('Book')->find_by_bibinfo($bibinfo_aggr,1);
				last if ($book_aggr);
			}
		
			($other_part_eans[0], $bibinfo_aggr->{ean13}) = ($bibinfo_aggr->{ean13}, $other_part_eans[0])if (!$book_aggr); #vrati puvodni EAN do bibinfa
		}
 		my $hash = {};
		$bibinfo_aggr->save_to_hash($hash);
		$book_aggr = undef if ($book_aggr and $book_aggr->get_column('id_parent')); # souborny zaznam nesmi byt cast mono./cislo per.

		if ($book_aggr) {
			# book zaznam existuje, aktualizovat
			warn 'BIBINFO_AGGR - EXISTUJE ... '.$book_aggr->id if($ENV{DEBUG});
			$book_aggr->update($hash);
		} else {
			# book zaznam neexistuje, vytvorit
			warn 'BIBINFO_AGGR - VYTVARIM' if($ENV{DEBUG});
			$book_aggr = DB->resultset('Book')->create($hash);
		}

		# ulozeni dalsich ISBN
		if (@other_part_eans){
			foreach my $param (@other_part_eans){
				DB->resultset('ProductParams')->find_or_create({book => $book_aggr->id, ean13 =>$param, nbn => $book_aggr->{nbn}, oclc => $book_aggr->{oclc}});
			}
		}

		# pokud se jedna o cast monografie musime nacist identifikatory casti
		if ($part_type eq "mono") {
			$bibinfo_params = {};
			# nacti parametry, ale odrizni prefix "part_"
			$bibinfo_params->{substr($_,5)} = decode_utf8($c->req->param($_)) foreach(Obalky::BibInfo->param_keys_part);
		}
		
		# nacti identifikatory casti
		$bibinfo_params->{$_} = decode_utf8($c->req->param($_)) foreach(Obalky::BibInfo->extended_keys_part);
		$bibinfo_params->{part_type} = 1 if ($part_type eq "mono"); # monografie
		$bibinfo_params->{part_type} = 2 if ($part_type eq "serial"); # periodikum
		$bibinfo_params->{id_parent} = $book_aggr->id;
		$bibinfo_params = DB->resultset('Book')->normalize_bibinfo($bibinfo_params);
		warn 'BIBINFO po normalizaci' if($ENV{DEBUG});
		warn Dumper($bibinfo_params) if($ENV{DEBUG});
	}

	# bibinfo skenovaneho zaznamu
	my $bibinfo = Obalky::BibInfo->new_from_params($bibinfo_params);
	 
	# vicero isbn
	my @other_eans;
	if ($bibinfo->{ean13}){
		@other_eans = split(',', $c->req->param('other_isbn'));
		@other_eans = map {Obalky::BibInfo->parse_code($_)} @other_eans;	
	}
	
    $self->_do_log("user $user book ".($bibinfo ? $bibinfo->to_string
                        : 'NENI bibinfo?? '.Dumper($bibinfo_params)));

	# vytvor permanentni uloziste - adresar /opt/obalky/www/import/$date/$seq
	my $today = today(); $today =~ s/\-//g;
	my $todayDir = "/opt/obalky/www/import/$today";
	mkdir $todayDir;
	my $seq = 1;
	$seq++ while(-d "$todayDir/$seq");
	my $dir = $todayDir."/".$seq;
	mkdir $dir or die "$dir: $!";

	# my $user = $c->user ? "".$c->user : $c->req->param('login');
	open(USER,">","$dir/user"); print USER $user; close(USER);

	# nahrej soubory - obalku a stranky obsahu
	# $c->param upload files, cover_tmp, contents_tmp
	# 'cover', 'toc_page_1'.. ?
	# my $uploads = $c->request->uploads;
	# $c->request->uploads->{field}

    $self->_do_log("uploading cover");
	$self->_upload_file($c,"cover","$dir/cover") if($c->req->param('cover'));

    $self->_do_log("cover done, uploading meta");
	$self->_upload_file($c,"meta","$dir/meta") if($c->req->param('meta'));

	# ze stranek obsahu vytvor PDF a prozen ho OCR
    $self->_do_log("meta done, uploading toc");
	if($c->req->param('toc')) {
		$self->_upload_file($c,"toc","$dir/toc_big.pdf");
		if($c->req->param('toc_sha1hex')) {
			my $tocContent = Obalky::Tools->slurp("$dir/toc_orig.pdf");
			die "toc file corrupted\n" if(sha1_hex($tocContent) ne 
										  $c->req->param('toc_sha1hex'));
		}
	}
    $self->_do_log("toc done");

	# nebo toc PDF zkonstruuj ze stranek
	for(my $page=1;;$page++) {
        last unless($c->req->param("toc_page_$page"));
        $self->_do_log("uploading toc page $page");
		$self->_upload_file($c,"toc_page_$page",sprintf("$dir/toc_page_%04d",
                                $page));
	}
    $self->_do_log("done uploading to $dir");

#	my $first = $c->req->param('toc_page_0001') || '';
	if(-f "$dir/toc_page_0001") {
		open(F,"<bytes","$dir/toc_page_0001");
		my $header = <F>; # nemame jmeno souboru, urcime z hlavicky
		close(F);
		if($header =~ /^\%PDF/) {
		   	$self->_do_log("toc.pdf: merging PDF with pdftk");
			system("pdftk $dir/toc_page_* cat output $dir/toc.pdf");
		} else {
		   	$self->_do_log("toc.pdf: merging with gm convert");
			#system("$CONVERT_BIN -density 150 $dir/toc_page_* -resize '50%' ".
			#		"-compress jpeg $dir/toc.pdf");
			system("$CONVERT_BIN -density 72 $dir/toc_page_* -compress jpeg $dir/toc.pdf");
		}
	} else {
	   	$self->_do_log("toc.pdf: using original PDF");
		system("cp $dir/toc_big.pdf $dir/toc.pdf");
	}

   	$self->_do_log("gm convert is done");
	# die "Konstrukce PDF z $toc_dir se nezdarila" unless(-s $toc_file);

	# URL vede k nam 
	my $product_url = "http://obalkyknih.cz/import/$today/$seq";

	# zkonstruuj media - prvky knizky, co eshop TOC zna (obalka, obsah)
	# Media->fields
	my $info = {};
	if(-s "$dir/cover") {
		$info->{cover_tmpfile} = "$dir/cover";
		$info->{cover_url} = "$product_url/cover";
	}
	if(-s "$dir/toc.pdf") {
		$info->{tocpdf_tmpfile} = "$dir/toc.pdf";
		$info->{toc_firstpage} = "$dir/toc_page_0001" 
						if(-s "$dir/toc_page_0001");
	}

    $self->_do_log("calling Obalky::Media->new_from_info(".Dumper($info).")");
	my $media = Obalky::Media->new_from_info($info);

# cover_url cover_tmpfile tocpdf_url tocpdf_tmpfile toctext 
# price_vat price_cur review_html review_impact review_rating

	# pro upload se pouziva "ObalkyKnih Upload" Eshop
    $self->_do_log("calling ...->get_upload_shop");
	my $eshop = DB->resultset('Eshop')->get_upload_eshop;

	# ok, ke knizce $bibinfo zaloz novy produkt ($media)
    $self->_do_log("calling ->add_product(".Dumper($bibinfo).",",
                            Dumper($media).",$product_url)");
	my $product = $eshop->add_product($bibinfo,$media,$product_url, undef, \@other_eans);

    $self->_do_log("ok, product ".$product->id." ready");

	# TODO: dat ocr do fronty? nebo tim bin/toc*.pl "daemonem" ?
	my $ocrFlag = $c->req->param('ocr');
	$ocrFlag = 0 unless(defined $ocrFlag);
    $self->_do_log("ocrFlag $ocrFlag");
	if((not $ocrFlag or (($ocrFlag ne 'no') and 
			($ocrFlag ne 'false') and ($ocrFlag ne '0')))) {
		my $tocId = $product->toc ? $product->toc->id : undef;
    	$self->_do_log("ocrFlag, tocId=".($tocId||"undef"));
		if($tocId) {
			if(-f "$dir/toc.pdf") { # na vstupu je PDF - prekopiruj PDF
				system("cp $dir/toc.pdf $OCR_DIR_INPUT/$tocId.pdf");
			} else { # vice souboru - vytvor slozku
				mkdir "$OCR_DIR_INPUT/$tocId";
				system("cp $dir/toc_page_* $OCR_DIR_INPUT/$tocId");
			}
		}
	}
	
	# AUTH - klienti s moznosti skenovat pouze jednoho autora (do v0.35)
	my $authId;
	$authId = $c->req->param("auth_id");
	if ($authId) {
		$self->_do_log("uploading auth");
		for(my $page=1;;$page++) {
	        last unless($c->req->param("auth_$page"));
	        $self->_do_log("uploading auth $page");
			$self->_upload_file($c,"auth_$page",sprintf("$dir/auth_%02d",$page));
		}
	    $self->_do_log("auth upload done");
	    
	    my $auth = DB->resultset('Auth')->find($authId);
	    
	    if(-s "$dir/auth_01" and $auth) {
			my $authMedia = Obalky::Media->new_from_info({
								cover_url => "$product_url/auth_01", 
								cover_tmpfile => "$dir/auth_01"
							});
			my $auth_source_url = "http://obalkyknih.cz/import/$today/$seq";
			my $authinfo = $auth->authinfo;
			my $auth_source = $eshop->add_auth_source($authinfo,$authMedia,$auth_source_url);
		}
		$self->_do_log("auth import done ".$auth->id) if (defined $auth->id);
	}
	
	# AUTH - klienti s moznosti skenovat vicere autory (od v0.36)
	my $authCnt;
	$authCnt = $c->req->param("auth_cnt");
	if ($authCnt) {
		 for(my $i=1; $i<=$authCnt; $i++) {
			$self->_do_log("uploading auth $i of $authCnt");
			last unless($c->req->param("auth_$i"));
		    $self->_do_log("uploading auth $i");
			$self->_upload_file($c,"auth_$i", "$dir/auth_$i");
		    $self->_do_log("auth upload done");
		    
		    my $authId = $c->req->param("auth_".$i."_id");
		    my $auth = DB->resultset('Auth')->find($authId);
		    
		    if(-s "$dir/auth_$i" and $auth) {
				my $authMedia = Obalky::Media->new_from_info({
									cover_url => "$product_url/auth_$i", 
									cover_tmpfile => "$dir/auth_$i"
								});
				my $auth_source_url = "http://obalkyknih.cz/import/$today/$seq";
				my $authinfo = $auth->authinfo;
				my $auth_source = $eshop->add_auth_source($authinfo,$authMedia,$auth_source_url);
			}
			$self->_do_log("auth $i of $authCnt import done ".$auth->id) if (defined $auth->id);
		}
	}

    $self->_do_log("import done");

	# vrat nejake OK nebo tak neco
	$c->response->content_type("text/plain");
	
	# client version
	my $version = "";
	$version = $c->req->param("version") if ($c->req->param("version"));
	
	if ($product->book and $version ne "") {
		$c->response->body($product->book->id);
	} else {
		$c->response->body('OK');
	}
}
 
# jen pomocna funkce pro ulozeni uploadovaneho souboru do FS
sub _upload_file {
    my($pkg,$c,$formname,$pathname) = @_;
	my $upload = $c->request->upload($formname) or die $formname;
	my $handle = $upload->fh;
    die "Chybi soubor \"$formname\"!\n" unless($handle);
    my $content = '';
    my $size = 0;
    if($pathname) { # muze to byt par giga, radsi necti do pameti..
        open(my $outfh,'>bytes',$pathname) or die "$pathname: $!\n";
        binmode $outfh;
        while (my $bytesread = read($handle, my $buffer, 16384)) {
            print $outfh $buffer;
            $size += $bytesread;
        }
        close($outfh);
    } else {
        while (my $bytesread = read($handle, my $buffer, 16384)) {
            $content .= $buffer;
        }
    }
    return $pathname ? $size : $content;
}

# vola frontend pro nacteni nastaveni push api (pri startu instance FE serveru)
sub get_settings_push : Local {
	my($self,$c) = @_;
	my $fe = DB->resultset('FeList')->search({ ip_addr=>$c->request->address });
	my @settings;
	my $resSettings = DB->resultset('LibrarySettingsPush')->search(undef,{
		join => 'library',
		'+select' => 'library.code',
		'+as' => 'sigla'});
	foreach ($resSettings->all) {
		push @settings, ({
							'sigla'=>$_->get_column('sigla'), 'url'=>$_->url, 
							'email'=>$_->email, 'full_container'=>$_->full_container, 
							'frequency'=>$_->frequency, 'item_count'=>$_->item_count
		});
	}
	$c->response->content_type("text/plain");
	$c->response->body( to_json({ 'count'=>$resSettings->count, 'settings'=>\@settings }) );
}

# vola frontend pro nacteni nastaveni citaci (pri startu instance FE serveru)
sub get_settings_citace : Local {
	my($self,$c) = @_;
	my $fe = DB->resultset('FeList')->search({ ip_addr=>$c->request->address });
	my @settings;
	my $resSettings = DB->resultset('LibrarySettingsCitace')->search(undef,{
		join => 'library',
		'+select' => 'library.code',
		'+as' => 'sigla'});
	foreach ($resSettings->all) {
		push @settings, ($_->type eq 'marcxml' ?
						{
							'sigla'=>$_->get_column('sigla'), 'type'=>$_->type, 'url'=>$_->url
						}		
						:
						{
							'sigla'=>$_->get_column('sigla'), 'type'=>$_->type, 'url'=>$_->url,
							'port'=>$_->z_port, 'database'=>$_->z_database, 'encoding'=>$_->z_encoding,
							'name'=>$_->z_name, 'password'=>$_->z_password, 'index_sysno'=>$_->z_index_sysno
						}
		);
	}
	$c->response->content_type("text/plain");
	$c->response->body( to_json({ 'count'=>$resSettings->count, 'settings'=>\@settings }) );
}

# vola frontend pro nacteni vsech prav (pri startu instance FE serveru)
sub get_perms : Local {
	my($self,$c) = @_;
	my $fe = DB->resultset('FeList')->search({ ip_addr=>$c->request->address });
	#return unless($fe->count || $c->request->address eq '127.0.0.1');
	my @perms;
	my $resPerms = DB->resultset('LibraryPerm')->search(undef,{
		join => 'library',
		'+select' => 'library.code',
		'+as' => 'sigla'});
	foreach ($resPerms->all) {
		push @perms, ($_->ref ? {'sigla'=>$_->get_column('sigla'), 'ref'=>$_->ref} : {'sigla'=>$_->get_column('sigla'), 'ip'=>$_->ip});
	}
	$c->response->content_type("text/plain");
	$c->response->body( to_json({ 'count'=>$resPerms->count, 'perms'=>\@perms }) );
}

sub auth : Local {
	my($self,$c) = @_;
	my $auth = eval { from_json($c->req->param("auth")) };
	$auth = [$auth] if(ref $auth eq 'HASH');
	$auth = [] unless $auth; 
	
	my($library,$session,$visitor) = Obalky->visit($c);
	
	my @auth;
	foreach my $this (ref $auth eq 'ARRAY' ? @$auth : []) {
		my($authid,$full) = $self->do_auth_request($c,$session,$library,$visitor,$this);
		push @auth, $full if(defined $full);
	}
	
	$c->response->content_type("text/javascript;charset=UTF-8");
	$c->response->body("obalky.callback(".to_json(\@auth).");\n");
}

sub do_auth_request {
	my($self,$c,$session,$library,$visitor,$this) = @_;
	
	my $authinfo = Obalky::AuthInfo->new_from_params($this->{authinfo});
	
	return unless($library and $authinfo);
	
    my($auth) = DB->resultset('Auth')->get_auth_record( $authinfo );
    return unless ($auth);
	
	$auth->enrich($this,$authinfo,$c->request->secure,$c->req->params);
	
	return ($auth->{auth_id},$this);
}

1;
