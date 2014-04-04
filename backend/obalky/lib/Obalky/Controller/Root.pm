package Obalky::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';

use Obalky::Media;

use Data::Dumper;
use utf8;

#use encoding 'latin-2';
#binmode(STDOUT,":encoding(latin-2)") or die;


#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Obalky::Controller::Root - Root Controller for Obalky

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 default

=cut

my %blue_info; # cache na pocty knizek
my $blue_timestamp;

sub blue_stash {
    my($self,$c) = @_;
	# todo: pocty cachovat..
	if(not $blue_timestamp or time - $blue_timestamp > 60*60) {
		$blue_info{covers} = DB->resultset('Cover')->count;
		$blue_info{tocs} = DB->resultset('Toc')->count;
		$blue_info{recent} = DB->resultset('Cover')->recent(16,1)
						unless($ENV{SKIP_RECENT});
		$blue_info{eshops} = [ grep { 
            not $_->is_internal and $_->logo_url and $_->id <= 140 } 
								DB->resultset('Eshop')->all ];
		my $libs = DB->resultset('Library')->count;
		$libs = 10*int($libs/10);
		$blue_info{libraries_at_least} = $libs;
		$blue_timestamp = time;
	}
	map { $c->stash->{$_} = $blue_info{$_} } keys %blue_info;
}

sub old : Local {
    my($self,$c) = @_;
	$self->blue_stash($c);
	$c->stash->{menu} = "index";
}

sub api : Local {
    my($self,$c) = @_;
#	$c->res->redirect("http://docs.google.com/View?docID=".
#			"0Ac2A7CGzH5t9ZGZtM3gyNGZfNjhjcmZ3amhjZg");
	$self->blue_stash($c);
	$c->stash->{menu} = "api";
}

sub abuse : Local {
    my($self,$c) = @_;
	return $c->res->redirect("login?return=".$c->req->uri) unless $c->user;

	if($c->req->param('revive')) {
		my $params = $c->req->body_params();
		foreach (keys %$params) {
			my($id) = (/^abuse_(\d+)$/) or next;
			my $abuse = DB->resultset('Abuse')->find($id) or next;
			my $book  = $abuse->book;
			my $cover = $abuse->cover;
			if($book and $cover) {
				warn "Reverting ".$cover->id." in book ".$book->id."\n";
				$book->update({ cover => $cover });
			}
			DB->resultset('Abuse')->search({ id => $id })->delete_all;
		}
	}
	$c->stash->{abused} = [ DB->resultset('Abuse')->all ];
	$c->stash->{menu} = "index";
}

sub stats : Local {
    my($self,$c) = @_;
	$c->stash->{libraries} = [ DB->resultset('Library')->all ];
	$c->stash->{eshops} = [ DB->resultset('Eshop')->all ];
	# echo 'select user,fullname,library.code,library.name from upload,user,library where upload.user = user.id and user.library = library.id;'|mysql|sort|uniq -c
	$c->stash->{menu} = "index";
}

sub test : Local {
    my($self,$c) = @_;
	$c->stash->{menu} = "index";
}

sub for_publishers : Local {
    my($self,$c) = @_;
	$c->stash->{eshops} = [ DB->resultset('Eshop')->all ];
	$c->stash->{menu} = "index";
}
sub for_libraries : Local {
    my($self,$c) = @_;
	# dat tam, ktere knihovny jsou zapojene?
	$c->stash->{menu} = "index";
}
sub for_patrons : Local {
    my($self,$c) = @_;
	$c->stash->{covers} = DB->resultset('Cover')->count;
	$c->stash->{tocs} = DB->resultset('Toc')->count;
	$c->stash->{menu} = "index";
}
sub for_developers : Local {
    my($self,$c) = @_;
	$c->stash->{menu} = "index";
}

sub stars : Local {
    my($self,$c) = @_;
	my $value = $c->req->param('value');
	my $float = ($value =~ /^\d+(\.\d+)?$/) ? (int($value/10))/2 : 0;
	$float = 0 if($float < 1.0);
	$float = 5 if($float > 5.0);
	my $img = sprintf("%1.1f",$float);
	$img =~ s/\.[12346789]$/.5/; # jen pro zichr..
	$c->serve_static_file($Obalky::Config::WWW_DIR."/img/stars/$img.gif");
}

sub dump  : Local {
    my($self,$c) = @_;
    $c->response->content_type("text/plain");
    $c->response->content_encoding("UTF-8");
    foreach my $lib (DB->resultset('Library')->all) {
        $c->response->write($lib->name."\n");
    }
}

sub file : Local {
	my($self,$c) = @_;
	my($table,$id,$method) = @{$c->req->arguments};
	my $object;
	if($table eq 'cover') {
		$object = DB->resultset('Cover')->find($id);
	} elsif($table eq 'toc') {
		$object = DB->resultset('Toc')->find($id);
	} else {
		die "File source $table not defined";
	}
	my($mime,$content,$ext) = $object->get_file($method) if($object);
	unless($content) {
		$c->response->status(404);
		$c->response->body("File '$table/$id".($method ? "/$method":"").
								"' not found.");
	} else {
		$c->response->content_type($mime);
#		$c->response->headers->header( 'Content-Disposition' =>  # ????
#			"attachment;filename=$table-$id-$method.$ext") if($ext eq 'pdf');
		$c->response->headers->header( 'Content-Disposition' =>  # ????
#			"inline") if($ext eq 'pdf');
			"inline;filename=$table-$id-$method.$ext") if($ext eq 'pdf');
		$c->response->body($content);
	}
}

sub login : Local {
	my($self,$c) = @_;
	my($user,$passwd) = ($c->req->param('email'),$c->req->param('password'));
	my $return = $c->req->param('return');
#	warn Dumper($c->models,$c->model('Obalky::AuthUser'));
	if($user and $passwd) {
		if($c->authenticate({ login => $user, password => $passwd })) {
			$c->res->redirect($return || "/index");
#			warn "user ".Dumper($c->user->get('login'))." authenticated\n";
		} else {
			$c->stash->{error} = 
				"Byl zadán neexistující e-mail nebo špatné heslo";
#			$c->res->redirect('signup');
		}
	} else {
#		$c->res->redirect('signup'); # login 
	}
	$c->stash->{email} = $user;
	$c->stash->{password} = $passwd;
	$c->stash->{'return'} = $return;
}
sub logout : Local {
	my($self,$c) = @_;
	my $return = $c->req->param('return');
	$c->logout();
	$c->res->redirect($return || "/index");
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub browse : Local {
	my($self,$c) = @_;
	return $c->res->redirect("login?return=".$c->req->uri) unless $c->user;
	$c->stash->{menu} = "browse";
}


sub upload : Local {
	my($self,$c) = @_;
	return $c->res->redirect("/login?return=".$c->req->uri) unless $c->user;

	my $file = $c->req->upload('file');
	my $url  = $c->req->param('url');
	undef $url if($url and $url eq 'http://');

	my $info = {
		file => $file, url => $url,
		login => scalar($c->user->get('login')),
		license => "free",
	};
	if($url or $file) {
		unless($c->req->param('free')) {
			$c->stash->{error} = "Nutno udělit souhlas s použitím.";
		} else {
			my $batch = eval { 
				DB->resultset('Upload')->upload(undef,undef,$info) };
			return $c->res->redirect("preview?batch=$batch") unless($@);
			$c->stash->{error} = $@;
		}
	}
	$c->stash->{url} = $url ? $url : "http://";
	$c->stash->{menu} = "upload";
}

sub preview : Local {
	my($self,$c) = @_;
	my $batch = $c->req->param('batch');

	my @images = DB->resultset('Upload')->images($batch);
	for(my $i=1;$i<@images;$i+=2) { $images[$i]->{odd} = 1 }

	$c->stash->{batch} = $batch;
	$c->stash->{menu} = "upload";
#	warn "   thumb[0]: ",$images[0]." - ".$images[0]->thumbfile;
	$c->stash->{images} = \@images;
}

sub default : Local {
	my($self,$c) = @_;
	$self->blue_stash($c);
	$c->stash->{menu} = "index";
}
sub about : Local {
	my($self,$c) = @_;
	$self->blue_stash($c);
	$c->stash->{menu} = "about";
}

sub scanner : Path('obalkyknih-scanner') {
	my($self,$c) = @_;
	$self->blue_stash($c);
	$c->stash->{menu} = "about";
}

sub edit : Local {
	my($self,$c) = @_;
	return $c->res->redirect("login?return=".$c->req->uri) unless $c->user;

	my($deleted,$approved) = (0,0);

	if($c->req->param('censor')) {
		foreach my $param ($c->req->param()) {
			my($id) = ($param =~ /^review\_(\d+)$/) or next;
			next unless($c->req->param($param)); # ON
			my $review = DB->resultset('Review')->find($id);
			if($c->req->param("delete_$id")) {
				$review->delete;
				$deleted++;
			} else {
				$review->update({ approved => $c->user->login });
				$approved++;
			}
		}
	}

	$c->stash->{deleted} = $deleted;
	$c->stash->{approved} = $approved;
	# TODO [% IF review.visitor AND NOT review.approved AND review.html_text %]
	my $month = $c->req->param('month') || 1;
	$c->stash->{month} = $month;
	$c->stash->{reviews} = [ DB->resultset('Review')->all_public($month) ];
	$c->stash->{menu} = "upload";
}

sub vote : Local {
	my($self,$c) = @_;
	my($library,$seance,$visitor) = Obalky->visit($c);
	my $book_id = $c->req->param('book');
	my $rating  = $c->req->param('vote');
	$rating = $rating < 1 ? 1 : ( $rating > 5 ? 5 : $rating);
	my $book = DB->resultset('Book')->find($book_id) if($book_id);
	$book->add_review($library,$visitor,{ 
		impact => $Obalky::Media::REVIEW_VOTE, rating => 20*$rating,
		html_text => '', visitor_ip => $c->req->address,
		visitor_name => '' }) if($book);
	$c->res->header('Content-type','text/plain; charset=utf-8');
	$c->res->body('{"width":"87","status":"Děkujeme!"}');
}

sub view : Local {
	my($self,$c) = @_;

	my($library,$seance,$visitor) = Obalky->visit($c);

	my $referer = $c->req->param('referer') || $c->req->referer;
	if($c->req->param('report')) {
		my $cover = DB->resultset('Cover')->find(
							$c->req->param("cover"));
		my $note = $c->req->param('note');
		my $spamQuestion = $c->req->param('spamQuestion');
		my $book = DB->resultset('Book')->find($c->req->param('book'));
		my $abuse = DB->resultset('Abuse')->
					abuse($book,$cover,$c->req->address,$referer,$note)
						if($spamQuestion eq 23);
		$c->stash->{error} = "Děkujeme za nahlášení, chybnou obálku se ".
					"pokusíme co nejdřív opravit." if($abuse);
	}

	if($c->req->param('review_add')) {
		my $name    = $c->req->param('review_name');
		my $book_id = $c->req->param('review_book');
		my $text    = $c->req->param('review_text');
		my $rating  = $c->req->param('review_rating');
		my $book = DB->resultset('Book')->find($book_id) if($book_id);
		die "Zakazano vkladani odkazu do recenzi" if($text =~ /http\:\/\//);
		if($name and $book and $text) {
			my $html = $text; $html =~ s/\n\n/<p>/g;
			my @reviews = $book->reviews;
			$book->add_review($library,$visitor,{ 
				impact => $Obalky::Media::REVIEW_COMMENT, rating => $rating, 
				html_text => $html, visitor_ip => $c->req->address,
				visitor_name => $name }) unless(@reviews > 300); # ?
		}
	}

	if($c->req->param('book_id')) {
		my $change = DB->resultset('Book')->find(
			{ id => $c->req->param('book_id') }) or die;
		my $cover_id = $c->req->param('set_cover');
		$change->update({ cover => $cover_id }) if($cover_id);
		my $toc_id   = $c->req->param('set_toc');
		$change->update({ toc => $toc_id }) if($toc_id);

		# invaliduj cache
		DB->resultset('Cache')->invalidate($change->id);
	}

	# pouzije parametry co prisli v dotazu
	my $bibinfo = Obalky::BibInfo->new_from_params($c->req->params, undef);
	my $book = $bibinfo ? DB->resultset('Book')->find_by_bibinfo($bibinfo) : undef;
	
	# z homepage se jako vyhledavani posila pouze parametr s nazvem ISBN a my se ted pokousime zjistit, jestli to nesedne na NBN, nebo OCLC
	if (not defined($book) and defined($c->req->param('isbn')) ) {
		my $code = $c->req->param('isbn');
		unless ( $code eq '' ) {
			# pokud se nenalezne zkus parametr ISBN pouzit jako NBN
			$bibinfo = Obalky::BibInfo->new_from_params({ nbn => $code }, undef);
			$book = $bibinfo ? DB->resultset('Book')->find_by_bibinfo($bibinfo) : undef;
			$c->response->redirect( '/view?nbn='.$code, 307 ) if ($book);
		
			# pokud stale nic, zkus OCLC
			if (not defined($book)) {
				$bibinfo = Obalky::BibInfo->new_from_params({ oclc => $code }, undef);
				$book = $bibinfo ? DB->resultset('Book')->find_by_bibinfo($bibinfo) : undef;
				$c->response->redirect( '/view?oclc='.$code, 307 ) if ($book);
			}
		}
	}
	
	my @books = $book ? ( $book->work ? $book->work->books : $book ) : ();

	foreach my $b1 (@books) {
		next unless($b1->tips);	
		$b1->{tips_ids} = [];
		foreach(split(/\s/,$b1->tips)) {
			my $b2 = eval { DB->resultset('Book')->find($_) };
			push @{$b1->{tips_ids}}, $b2 if($b2 and $b2->title);
		}
	}

	$c->stash->{books}   = [ @books ];#\@info;
	$c->stash->{referer} = $referer;
	$c->stash->{detail}  = $c->user ? 1 : 0; # prihlasenym i detaily
	$c->stash->{seznam_main_image} = ($books[0] and $books[0]->cover) ? 
		$books[0]->cover->get_cover_url : undef;

	my $ip = $c->req->address; $ip =~ s/\.\d+$/.../;
	$c->stash->{visitor_blurred_ip} = $ip;
	
	# same as in index()
	$c->stash->{menu} = "index";
}

sub signup : Local {
	my($self,$c) = @_;

	my $signed = 0;
	if($c->req->param('signup')) {
		eval { $signed = DB->resultset('User')->signup($c->req->params) };
		$c->stash->{error} = $@ if($@);
	}
	$c->stash->{signed} = $signed;
	$c->stash->{$_} = $c->req->param($_) 
		for(qw/fullname email protirob libcode libname libaddress libcity 
			   logo_url eshop_name eshop_url
			   libemailboss libemailads libskipmember xmlfeed/);
	$c->stash->{libopac} = $c->req->param('libopac') ?
							$c->req->param('libopac') : "http://";
	$c->stash->{menu} = "index";
}

sub lostpassword : Local {
	my($self,$c) = @_;

	my $email = $c->req->param('email');
	my $reset = $c->req->param('reset');
	my $pass1 = $c->req->param('pass1');
	my $pass2 = $c->req->param('pass2');

	if($email) {
		eval { $c->stash->{sent} = 
			DB->resultset('User')->sendpassword($email) };
	}
	if($pass1 and $pass2) {
		eval { $c->stash->{reseted} = 
			DB->resultset('User')->resetpassword($reset,$pass1,$pass2) };
	}

	$c->stash->{error} = $@ if($@);
	$c->stash->{'reset'} = $reset;
	$c->stash->{email} = $email;
	$c->stash->{menu} = "index";
}

use HTML::TagCloud;
use Data::Dumper;

sub tags : Local {
	my($self,$c) = @_;

	my $cloud = HTML::TagCloud->new;
	open(LIST,"<utf8","/opt/obalky/doc/tags-655-c.txt") or die;
	while(<LIST>) {
		my($count,$text) = (/^\s+(\d+)\s+(.+)$/) or next;
		$cloud->add($text, "http://obalkyknih.cz/tag/$.", $count);
	}
	close(LIST);	
#	$c->stash->{warning} = Dumper($c->models);
	$c->stash->{tagcloud} = $cloud->html_and_css(50);
}

sub insert : Local {
	my($self,$c) = @_;
	return $c->res->redirect("/login?return=".$c->req->uri) unless $c->user;

	my $batch = $c->req->param('batch');

	my $list;
	foreach(keys %{$c->req->params}) {
		$list->{$2}->{$1} = $c->req->param($_) if(/^(.+)\_(\d+)$/);
	}
	DB->resultset('Upload')->do_import($batch,$list);

	$c->stash->{menu} = "upload";
	#return $c->res->redirect("browse"); # s nejakym argumentem?
	return $c->res->redirect("index"); # nebo podekovat?
}

#sub end : ActionClass('RenderView') {
sub end : Private {
	my($self,$c) = @_;
    return 1 if $c->response->status =~ /^3\d\d$/;
    return 1 if $c->response->body;
    unless ( $c->response->content_type ) {
        $c->response->content_type('text/html; charset=utf-8');
    }

    if($c->stash->{menu}) {
        my $menu = "menu_".$c->stash->{menu}; # u tovarny zbytecne...
        $c->stash->{$menu} = "menu_selected";
    }
#	warn "end() user: ".($c->user ? "ok: ".$c->user->get('login'):"fail")."\n";
	$self->blue_stash($c);
	$c->stash->{user} = $c->user ? $c->user->get('login') : undef;
	$c->forward('Obalky::View::TT');	
}


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
