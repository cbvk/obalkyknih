
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

	my($this,$bibinfo,$permalink) = (undef,undef,undef);
	if ($book_id) {
		my $book = DB->resultset('Book')->find($book_id);
		$bibinfo = Obalky::BibInfo->new($book);
		$permalink = Obalky::Tools->fix_permalink('a');
	} else {
		$this = from_json($c->req->param("book"));
		$bibinfo = Obalky::BibInfo->new_from_params($this->{bibinfo});
		$permalink = Obalky::Tools->fix_permalink($this->{permalink});
	}

	# v dotazu chybi minimalni udaje, ignoruj..
#	unless($library and $bibinfo and $permalink) {
#		warn "Chybi minimalni udaje, ignoruju (lib=".($library?$library->code:"").")...\n";
#	}

	return unless($library and $bibinfo and $permalink);

	my($book,$record) = DB->resultset('Marc')->get_book_record( $library, $permalink, $bibinfo );

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

	$book->enrich($this,$library,$permalink,$bibinfo,$c->request->secure);
	
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

	my($this,$bibinfo,$permalink,$book,$book_id) = (undef,undef,undef,undef,undef);
	my $review = DB->resultset('Review')->search({ library=>$library->id, library_id_review=>$id })->next;
	$book_id = $review->book->id if ($review);
	if ($book_id) {
		$book = DB->resultset('Book')->find($book_id);
		$bibinfo = Obalky::BibInfo->new($book);
		$permalink = Obalky::Tools->fix_permalink('a');
		$this->{ean} = $book->ean13 if $book->ean13;
		$this->{nbn}  = $book->nbn if $book->nbn;
		$this->{oclc} = $book->oclc if $book->oclc;
	} else {
		return;
	}

	return unless($library and $bibinfo and $permalink);

	my $review_params = {
		id => $id,
		sigla => $sigla
	};

	# zaznam komentare neexistuje, vytvarime
	$book->del_review($review,$library,$visitor,$review_params);

	$book->enrich($this,$library,$permalink,$bibinfo,$c->request->secure);
	
	# vyvolej promazani metadat ze vsech frontend serveru
	DB->resultset('FeSync')->request_sync_review($book,$c->request->secure);

	$c->response->content_type("text/javascript;charset=UTF-8");
	$c->response->body("obalky.callback(".to_json([$this]).");\n");
}

sub do_book_request {
	my($self,$c,$session,$library,$visitor,$this) = @_;

	my $bibinfo = Obalky::BibInfo->new_from_params($this->{bibinfo});
	my $permalink = Obalky::Tools->fix_permalink($this->{permalink});

	# v dotazu chybi minimalni udaje, ignoruj..
	#unless($library and $bibinfo and $permalink) {
		# ale nevypisuj, je toho hodne..
	#	warn "Chybi minimalni udaje, ignoruju (lib=".($library?$library->code:"").",permalink=".($permalink||'').",bibinfo=".($bibinfo||'').")...\n";
	#}
	return unless($library and $bibinfo and $permalink);
	
    my($book,$record) = DB->resultset('Marc')->get_book_record( $library, $permalink, $bibinfo );
	
	# pokud se zaznam nenasel, a neni vytvoren novy (napr. v pripade dotazu na periodikum, nebo vicesvazkovou monografii)
	# vratime souborny zaznam - jeho part_most_recent
	my $generate_part_dummy = 0;
	my ($bib_orig_part_no, $bib_orig_part_name, $bib_orig_part_year, $bib_orig_part_volume) = ($bibinfo->{part_no}, $bibinfo->{part_name}, $bibinfo->{part_year}, $bibinfo->{part_volume});
	unless ($book) {
		$bibinfo->{part_no} = $bibinfo->{part_name} = $bibinfo->{part_year} = $bibinfo->{part_volume} = undef;
		($book,$record) = DB->resultset('Marc')->get_book_record( $library, $permalink, $bibinfo );
		$generate_part_dummy = 1;
	}

	$book->enrich($this,$library,$permalink,$bibinfo,$c->request->secure,$c->req->params);
	
	# pokud skutecna cast monografie, nebo periodika neexistovala, byl vyhledan part_most_recent souborneho zaznamu a
	# potrebujeme tento zaznam zmenit na dummy (pseudo zaznam) = identifikatory casti nahradit za ty, ktere byly v pozadavku
	if ($generate_part_dummy) {
		delete $this->{part_most_recent};
		delete $this->{part_no};   delete $this->{part_name};
		delete $this->{part_year}; delete $this->{part_volume};
		$this->{part_no} = $bib_orig_part_no if ($bib_orig_part_no);
		$this->{part_name} = $bib_orig_part_name if ($bib_orig_part_name);
		$this->{part_year} = $bib_orig_part_year if ($bib_orig_part_year);
		$this->{part_volume} = $bib_orig_part_volume if ($bib_orig_part_volume);
		$this->{part_dummy} = 1;
	}

	# zapis do DB #lastrequests [ visitor_id, session?, $book->id, $record->id ]
	#if($tip) { nelogujeme, pretikaji disky
	#	DB->resultset('Lastrequests')->create({ 
	#		library => $library->id, book => $book->id, 
	#		visitor => $visitor->id, marc => $record ? $record->id : undef, 
	#		session_info => $session});
	#}

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

	# autentizuj uzivatelem, misto cookies staci user/password parametry
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
	
		my $hash = {};
		my $bibinfo_aggr = Obalky::BibInfo->new_from_params($bibinfo_params);
		$bibinfo_aggr->save_to_hash($hash);
		
		unless ($c->req->param("part_no") or $c->req->param("part_name")) { # chyby povinny parametr
			$c->response->content_type("text/plain");
			$c->response->body("Missing params part_year, or part_volume, part_no, or part_name.");
			return;
		}

		my $book_aggr = DB->resultset('Book')->find_by_bibinfo($bibinfo_aggr);
		if ($book_aggr) {
			# book zaznam existuje, aktualizovat
			$book_aggr->update($hash);
		} else {
			# book zaznam neexistuje, vytvorit
			$book_aggr = DB->resultset('Book')->create($hash);
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
	}
	#warn Dumper($c->req); warn Dumper($bibinfo_params); die; #DEBUG

	# bibinfo skenovaneho zaznamu
	my $bibinfo = Obalky::BibInfo->new_from_params($bibinfo_params);

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
		   	$self->_do_log("toc.pdf: mergin'(díl 1, sv. 2 : Ladislav Horáček - Paseka : váz.)'g PDF with pdftk");
			system("pdftk $dir/toc_page_* cat output $dir/toc.pdf");
		} else {
		   	$self->_do_log("toc.pdf: merging with gm convert");
			system("$CONVERT_BIN -density 150 $dir/toc_page_* -resize '50%' ".
					"-compress jpeg $dir/toc.pdf");
		}
	} else {
#	   	$self->_do_log("executing gm convert 150dpi/50% toc_big.pdf toc.pdf");
#		system("$CONVERT_BIN -density 150 $dir/toc_big.pdf -resize '50%' ".
#				"-compress jpeg $dir/toc.pdf") if(-s "$dir/toc_big.pdf");
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
	my $product = $eshop->add_product($bibinfo,$media,$product_url);

    $self->_do_log("ok, product ".$product->id." ready");

	# TODO: dat ocr do fronty? nebo tim bin/toc*.pl "daemonem" ?
	my $ocrFlag = $c->req->param('ocr');
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

    $self->_do_log("import done");

	# vrat nejake OK nebo tak neco
	$c->response->content_type("text/plain");
	$c->response->body("OK");
#	die Dumper($dir,$bibinfo,$info,$media,"$eshop",$product_url);
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

1;
