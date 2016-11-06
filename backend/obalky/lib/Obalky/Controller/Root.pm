package Obalky::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';

use Obalky::Media;

use Data::Dumper;
use File::Copy qw(move);
use URI::Encode qw(uri_encode);
use utf8;
use Business::ISBN;
use Business::ISSN;


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
# !!! uprava zobrazeni logo JN 2015-09-10
            not $_->is_internal and $_->logo_url and $_->id <= 1000000} 
###            not $_->is_internal and $_->logo_url and $_->checkin > 0} 
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
			my $toc = $abuse->toc;
			if($book and $cover) {
				warn "Reverting ".$cover->id." in book ".$book->id."\n";
				$book->update({ cover => $cover });
			}
			if($book and $toc) {
				warn "Reverting ".$toc->id." in book ".$book->id."\n";
				$book->update({ toc => $toc });
			}
			DB->resultset('Abuse')->search({ id => $id })->delete_all;
			
			# synchronizuj s frontend
			DB->resultset('FeSync')->book_sync_remove($book->id);
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
			if ($c->user->get('flag_library_admin') == '1') {
				$c->res->redirect($return || "/account");
				return;
			}
			$c->res->redirect($return || "/upload");
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

sub settings_citace : Local {
    my($self,$c) = @_;
    my $signed = $c->user ? 1 : 0;
    unless ($signed) {
    	#uzivatelsky ucet jen pro prihlasene uzivatele
    	$c->res->redirect("index");
    	return;
    }
    unless ($c->user->get('flag_library_admin')) {
    	#presmeruj na uzivatelsky ucet ne-spravce knihovny
		$c->res->redirect("/account_user");
		return;
	}
    
    my $username = $c->user->get_column('login');
    if ($username eq $Obalky::ADMIN_EMAIL && !$c->req->param('i')) {
    	#spravce ma k dispozici spravu vsech knihoven
    	$c->res->redirect("admin_library");
    	return;
    }
    
    my $library_admin = $c->user->get_column('flag_library_admin');
    
    my $id = $c->user->get_column('library');
    $id = $c->req->param('i') if ($username eq $Obalky::ADMIN_EMAIL);
    my $library = $signed ? DB->resultset('Library')->find($id) : 0;
    
    if ($library) {
    	# Pridej nastaveni
	    if($c->req->param('new')) {
			eval { my $res = DB->resultset('LibrarySettingsCitace')->add_permission($c->req->params, $library) };
			$c->stash->{error} = $@ if($@);
		}
		# Edituj nastaveni
	    if($c->req->param('e')) {
			eval { my $res = DB->resultset('LibrarySettingsCitace')->edit_permission($c->req->param('e'), $c->req->params, $library) };
			$c->stash->{error} = $@ if($@);
		}
    	# Odstran nastaveni
	    if($c->req->param('d')) {
			eval { my $res = DB->resultset('LibrarySettingsCitace')->remove_permission($c->req->param('d'), $library) };
			$c->stash->{error} = $@ if($@);
		}
		# Vypis nastaveni
    	$c->stash->{settings} = DB->resultset('LibrarySettingsCitace')->find({ library=>$id });
    }
    
    $c->stash->{admin_page} = 'account';
    $c->stash->{signed} = $signed;
	$c->stash->{library} = $library;
	$c->stash->{is_admin} = $c->req->param('i') ? 1 : 0;
	$c->stash->{library_admin} = $library_admin;
	$c->stash->{params} = $c->req->params;
}

sub account : Local {
    my($self,$c) = @_;
    my $signed = $c->user ? 1 : 0;
    unless ($signed) {
    	#uzivatelsky ucet jen pro prihlasene uzivatele
    	$c->res->redirect("index");
    	return;
    }
    unless ($c->user->get('flag_library_admin')) {
    	#presmeruj na uzivatelsky ucet ne-spravce knihovny
		$c->res->redirect("/account_user");
		return;
	}
    
    my $username = $c->user->get_column('login');
    if ($username eq $Obalky::ADMIN_EMAIL && !$c->req->param('i')) {
    	#spravce ma k dispozici spravu vsech knihoven
    	$c->res->redirect("admin_library");
    	return;
    }
    
    my $library_admin = $c->user->get_column('flag_library_admin');
    
    my $id = $c->user->get_column('library');
    $id = $c->req->param('i') if ($username eq $Obalky::ADMIN_EMAIL);
    my $library = $signed ? DB->resultset('Library')->find($id) : 0;
    
    if ($library) {
    	# Pridej opravneni
	    if($c->req->param('new')) {
			eval { my $res = DB->resultset('LibraryPerm')->add_permission($c->req->params, $library) };
			$c->stash->{error} = $@ if($@);
		}
		# Edituj opravneni
	    if($c->req->param('e')) {
			eval { my $res = DB->resultset('LibraryPerm')->edit_permission($c->req->param('e'), $c->req->params, $library) };
			$c->stash->{error} = $@ if($@);
		}
    	# Deaktivuj opravneni
	    if($c->req->param('d')) {
			eval { my $res = DB->resultset('LibraryPerm')->remove_permission($c->req->param('d'), $library) };
			$c->stash->{error} = $@ if($@);
		}
    	# Vypis opravneni
    	$c->stash->{ref_list} = [ DB->resultset('LibraryPerm')->search({ library=>$id, ref=>{'!=', undef} })->all ];
    	$c->stash->{ip_list} = [ DB->resultset('LibraryPerm')->search({ library=>$id, ip=>{'!=', undef} })->all ];
    }
    
    $c->stash->{admin_page} = 'account';
    $c->stash->{signed} = $signed;
	$c->stash->{library} = $library;
	$c->stash->{is_admin} = $c->req->param('i') ? 1 : 0;
	$c->stash->{library_admin} = $library_admin;
	$c->stash->{params} = $c->req->params;
}
sub account_user : Local {
    my($self,$c) = @_;
    my $signed = $c->user ? 1 : 0;
    unless ($signed) {
    	#uzivatelsky ucet jen pro prihlasene uzivatele
    	$c->res->redirect("index");
    	return;
    }
    
    my $user = DB->resultset('User')->find($c->user->id);
    my $library_admin = $user->get_column('flag_library_admin');
    my $flag_review_report = $user->get_column('flag_review_report');
    
    # zmena nastaveni (hesla)
    if ($c->req->param('submit')) {
    	$flag_review_report = $c->req->param('flag_review_report') ? 1 : 0;
    	$c->stash->{error} = DB->resultset('User')->change_password($c->user, $c->req->param('email_old'), $c->req->param('email_new'), $c->req->param('email_confirm'), $flag_review_report);
    	# mozna zmena checkboxu "Zasilat tydenni report nove publikovanych hodnoceni"
    	DB->resultset('User')->find($c->user->id)->update({ flag_review_report => $flag_review_report }) if ($library_admin == 1);
    }
    
    $c->stash->{admin_page} = 'account_user';
    $c->stash->{signed} = $signed;
    $c->stash->{library_admin} = $library_admin;
    $c->stash->{flag_review_report} = $flag_review_report;
	$c->stash->{params} = $c->req->params;
}
sub account_review : Local {
    my($self,$c) = @_;
    my $signed = $c->user ? 1 : 0;
    unless ($signed) {
    	#uzivatelsky ucet jen pro prihlasene uzivatele
    	$c->res->redirect("index");
    	return;
    }
    unless ($c->user->get('flag_library_admin')) {
    	#presmeruj na uzivatelsky ucet ne-spravce knihovny
		$c->res->redirect("/account_user");
		return;
	}
    
    my $username = $c->user->get_column('login');
    if ($username eq $Obalky::ADMIN_EMAIL && !$c->req->param('i')) {
    	#spravce ma k dispozici spravu vsech knihoven
    	$c->res->redirect("admin_library");
    	return;
    }
    
    my $library_admin = $c->user->get_column('flag_library_admin');
    
    my $id = $c->user->get_column('library');
    $id = $c->req->param('i') if ($username eq $Obalky::ADMIN_EMAIL);
    my $library = $signed ? DB->resultset('Library')->find($id) : 0;
    
    if ($library) {
    	# Smazani prispevku
	    if($c->req->param('d')) {
			eval { my $res = DB->resultset('Review')->remove_review($c->req->param('d'), $library) };
			$c->stash->{error} = $@ if($@);
		}
    	# Vypis komentaru
    	my $search_params = { library=>$library->get_column('id') };
    	$search_params->{html_text} = { '!='=>'' };
    	my($page, $max_page, $per_page, $order, $order_dir, $filter_val, $filter_key) = DB::pagination($c, 'Review', $search_params);
	    $c->stash->{cur_page} = $page;
	    $c->stash->{max_page} = $max_page;
	    $c->stash->{per_page} = $per_page;
	    $c->stash->{order} = $order;
	    $c->stash->{order_dir} = $order_dir;
	    $c->stash->{filter_val} = $filter_val;
	    $c->stash->{filter_key} = $filter_key;
	    $search_params->{$filter_key} = { '-like'=>"%$filter_val%" } if ($filter_key);
	    $c->stash->{review_list} = [ DB->resultset('Review')->search($search_params, {
	    	offset => ($page-1)*$per_page,
	    	rows => $per_page,
	    	order_by => { $order_dir==1 ? '-asc' : '-desc' => $order },
	    	join => 'book',
	    	'+select' => 'book.title',
			'+as' => 'title'
	    })->all ];
    }
    
    $c->stash->{admin_page} = 'account_review';
    $c->stash->{signed} = $signed;
	$c->stash->{library} = $library;
	$c->stash->{is_admin} = $c->req->param('i') ? 1 : 0;
	$c->stash->{library_admin} = $library_admin;
	$c->stash->{params} = $c->req->params;
}
sub account_stats : Local {
    my($self,$c) = @_;
    my $signed = $c->user ? 1 : 0;
    unless ($signed) {
    	$c->res->redirect("index");
    	return;
    }
    my $username = $c->user->get_column('login');
    my $library = $signed ? $c->user->get_column('library') : 0;
    my $library_admin = $c->user->get_column('flag_library_admin');
    $library = $c->req->param('i') if ($username eq $Obalky::ADMIN_EMAIL);
    
    if ($library == 50000) {
    	$c->res->redirect("admin_stats");
    	return;
    }
    
    $c->stash->{stat1} = [ DB->resultset('FeStat')->req_stats_daily($library)->all ];    
    $c->stash->{stat2} = [ DB->resultset('FeStat')->req_stats_monthly($library)->all ];
    
    $c->stash->{admin_page} = 'account_stats';
    $c->stash->{signed} = $signed;
    $c->stash->{library_admin} = $library_admin;
}
sub admin_stats : Local {
    my($self,$c) = @_;
    my $signed = $c->user ? 1 : 0;
    unless ($signed) {
    	$c->res->redirect("index");
    	return;
    }
    my $username = $c->user->get_column('login');
    unless ($username eq $Obalky::ADMIN_EMAIL) {
    	$c->res->redirect("account_stats");
    	return;
    }
    my $library = $signed ? $c->user->get_column('library') : 0;
    my $library_admin = $c->user->get_column('flag_library_admin');
    $library = $c->req->param('i') if ($username eq $Obalky::ADMIN_EMAIL);
    
    $c->stash->{stat1} = [ DB->resultset('FeStat')->req_stats_daily(50000)->all ];    
    $c->stash->{stat2} = [ DB->resultset('FeStat')->req_stats_monthly(50000)->all ];
    $c->stash->{stat3} = [ DB->resultset('FeStat')->fe_stats_daily(50000)->all ];
    $c->stash->{stat4} = [ DB->resultset('FeStat')->fe_stats_monthly(50000)->all ];
    $c->stash->{stat5} = DB->resultset('FeStat')->top_sigla_by_requests(10);
    
    $c->stash->{admin_page} = 'account_stats';
    $c->stash->{signed} = $signed;
    $c->stash->{library_admin} = $library_admin;
}
sub logout : Local {
	my($self,$c) = @_;
	my $return = $c->req->param('return');
	$c->logout();
	$c->res->redirect($return || "/index");
}

=head2 admin_library

Stranka se seznamem vsech knihoven. Spravce muze vstoupit do konta kazde z nich.

=cut
sub admin_library : Local {
	my($self,$c) = @_;
	
	unless ($c->user) {
		$c->res->redirect("index");
    	return;
    }
	if ($c->user->get_column('login') ne $Obalky::ADMIN_EMAIL) {
    	#pouze spravce ma k dispozici spravu vsech knihoven
    	$c->res->redirect("account");
    	return;
    }
    # Library activate
    if($c->req->param('a')) {
		eval { my $res = DB->resultset('Library')->activate_library($c->req->param('a')) };
		$c->stash->{error} = $@ if($@);
	}
    # Library deactivate
    if($c->req->param('d')) {
		eval { my $res = DB->resultset('Library')->deactivate_library($c->req->param('d')) };
		$c->stash->{error} = $@ if($@);
	}
    
    my($page, $max_page, $per_page, $order, $order_dir, $filter_val, $filter_key) = DB::pagination($c, 'Library');
    
    $c->stash->{cur_page} = $page;
    $c->stash->{max_page} = $max_page;
    $c->stash->{per_page} = $per_page;
    $c->stash->{order} = $order;
    $c->stash->{order_dir} = $order_dir;
    $c->stash->{filter_val} = $filter_val;
    $c->stash->{filter_key} = $filter_key;
    my $search_params = undef;
    $search_params->{$filter_key} = { '-like'=>"%$filter_val%" } if ($filter_key);
    $c->stash->{library_list} = [ DB->resultset('Library')->search($search_params, {
    	offset => ($page-1)*$per_page,
    	rows => $per_page,
    	order_by => { $order_dir==1 ? '-asc' : '-desc' => $order },
    	'+select' => '(SELECT COUNT(*) FROM library_perms WHERE `library`=me.`id`)',
		'+as' => 'permcount'
    })->all ];
    
    $c->stash->{admin_page} = 'admin_library';
    $c->stash->{signed} = $c->user ? 1 : 0;
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
		my $batch = eval {
			DB->resultset('Upload')->upload(undef,undef,$info) };
		return $c->res->redirect("preview?batch=$batch") unless($@);
		$c->stash->{error} = $@;
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
		my ($cover, $toc);
		$cover = DB->resultset('Cover')->find($c->req->param("cover")) if ($c->req->param("cover"));
		$toc = DB->resultset('Toc')->find($c->req->param("toc")) if ($c->req->param("toc"));
		my $note = $c->req->param('note');
		my $spamQuestion = $c->req->param('spamQuestion');
		my $book = DB->resultset('Book')->find($c->req->param('book'));
		my $abuse = DB->resultset('Abuse')->
					abuse($book,$cover,$toc,$c->req->address,$referer,$note)
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

	if($c->req->param('book_id') and $c->req->param('set_cover')) {
		my $change = DB->resultset('Book')->find(
			{ id => $c->req->param('book_id') }) or die;
		my $cover_id = $c->req->param('set_cover');
		$change->update({ cover => $cover_id }) if($cover_id);
		my $toc_id   = $c->req->param('set_toc');
		$change->update({ toc => $toc_id }) if($toc_id);
		
		# synchronizuj s frontend
		DB->resultset('FeSync')->book_sync_remove($change->id);

		# invaliduj cache
		DB->resultset('Cache')->invalidate($change->id);
	}

	#vyber knihy budto podle parametru isbn,nbn,oclc, nebo presne podle zadaneho ID zaznamu
	my ($book,$bibinfo) = (undef,undef);
	if ($c->req->param('book_id')) {
		$book = DB->resultset('Book')->find($c->req->param('book_id'));
	} else {
		# pouzije parametry co prisli v dotazu
		$bibinfo = Obalky::BibInfo->new_from_params($c->req->params, undef);
		$book = $bibinfo ? DB->resultset('Book')->find_by_bibinfo($bibinfo) : undef;
	}
	
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
			
			# autorita podle ID
			if (not defined($book)) {
				my $authinfo = Obalky::AuthInfo->new_from_params({ auth_id => $c->req->param('isbn') });
				my $auth = DB->resultset('Auth')->get_auth_record( $authinfo );
				$c->response->redirect( '/view_auth?auth_id='.$auth->id, 307 ) if ($auth);
			}
			
			# autorita podle jmena
			if (not defined($book)) {
				my $searchPhrase;
				my @words = split / /, $c->req->param('isbn');
				@{$searchPhrase->{'-and'}} = ();
				foreach (@words) {
					push @{$searchPhrase->{'-and'}}, { 'auth_name' => { -like => '%'.$_.'%' } };
				}
				my $resauth = DB->resultset('Auth')->search($searchPhrase, { limit=>1 });
				#multiple records = list page
				if ($resauth->count gt 1) {
					my $authName = uri_encode($c->req->param('isbn'));
					$c->response->redirect( '/list_auth?auth_name='.$authName, 307 );
					return;
				}
				# single record = detail page
				my $auth = $resauth->next;
				$c->response->redirect( '/view_auth?auth_id='.$auth->id, 307 ) if ($auth);
			}
		}
	}
	
	# nalezeni casti monografii/periodik
	my $sort_by = 'id'; # default razeni od nejnovejsiho skenovaneho
	$sort_by = $c->req->param('sort_by') if ($c->req->param('sort_by'));
	$c->stash->{sort_by} = $sort_by;
	
	my @idf; # seznam book_id, ktere maji byt zobrazeny; pouziva se pri backlinku rozsahu periodik
	my $idf = $c->req->param('idf');
	@idf = split(',', $idf) if ($idf);
	
	my @parts = DB->resultset('Book')->get_parts($book, $sort_by, \@idf);
	if (@parts) {
		my $book_recent;
		my @parts_tmp = @parts;
		$book_recent = $book->get_most_recent unless ($idf);
		$book_recent = pop @parts_tmp if ($idf);
		$c->stash->{recent_book_id} = $book_recent->id if ($book_recent);
		$c->stash->{recent_cover} = $book_recent->cover if ($book_recent and $book_recent->cover);
		$c->stash->{recent_toc} = $book_recent->toc if ($book_recent and $book_recent->toc);
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

	$c->stash->{books}   = [ @books ];
	$c->stash->{parts}   = [ @parts ] if (@parts);
	$c->stash->{idf}     = $idf if ($idf);
	$c->stash->{referer} = $referer;
	$c->stash->{detail}  = $c->user ? 1 : 0; # prihlasenym i detaily
	$c->stash->{seznam_main_image} = ($books[0] and $books[0]->cover) ? 
		$books[0]->cover->get_cover_url : undef;

	my $ip = $c->req->address; $ip =~ s/\.\d+$/.../;
	$c->stash->{visitor_blurred_ip} = $ip;
	
	# same as in index()
	$c->stash->{menu} = "index";
}

sub view_auth : Local {
	my($self,$c) = @_;
	my($library,$seance,$visitor) = Obalky->visit($c);
	
	my $referer = $c->req->param('referer') || $c->req->referer;
	
	my $auth = undef;
	return unless($c->req->param('auth_id'));
	
	# ziskani zaznamu autority
	if ($c->req->param('auth_id')) {
		$auth = DB->resultset('Auth')->find($c->req->param('auth_id'));
	}
	
	# upload obalky autority
	if ($c->req->param('auth_upload')) {
		my $upload;
		my $file = $c->req->upload('file');	
		my $info = {
			file => $file, url => undef,
			login => scalar($c->user->get('login')),
			license => 'free'
		};
		if ($file) {
			$info->{'file_id'} = $auth->id;
			my $batch = eval { DB->resultset('Upload')->upload(undef,undef,$info) };
			$upload = DB->resultset('Upload')->search({ batch => $batch })->next;
		}
		if ($upload) {
	        my $media = Obalky::Media->new_from_info({
							cover_url => $upload->cover_url, 
							cover_tmpfile => $upload->cover_tmpfile });
			$auth->add_cover($media);
			DB->resultset('FeSync')->auth_sync_remove($auth->id);
		}
	}
	
	return unless($auth);
	
	my @auths = ( $auth );
	
	$c->stash->{auths}   = [ @auths ];
	$c->stash->{referer} = $referer;
	$c->stash->{detail}  = $c->user ? 1 : 0; # prihlasenym i detaily
	$c->stash->{seznam_main_image} = ($auths[0] and $auths[0]->cover) ? 
		$auths[0]->cover->get_cover_url : undef;

	my $ip = $c->req->address; $ip =~ s/\.\d+$/.../;
	$c->stash->{visitor_blurred_ip} = $ip;
	
	# same as in index()
	$c->stash->{user} = $c->user ? $c->user->get('login') : undef;
	$c->stash->{menu} = "index";
}

sub list_auth : Local {
	my($self,$c) = @_;
	my($library,$seance,$visitor) = Obalky->visit($c);
	
	my $referer = $c->req->param('referer') || $c->req->referer;
	
	my $offset = 0;
	$offset = $c->req->param('offset') if ($c->req->param('offset'));
	
	my ($resAuth, $searchPhrase) = (undef, undef);
	
	if ($c->req->param('auth_name')) {
		my @words = split / /, $c->req->param('auth_name');
		@{$searchPhrase->{'-and'}} = ();
		foreach (@words) {
			push @{$searchPhrase->{'-and'}}, { 'auth_name' => { -like => '%'.$_.'%' } };
		}
	}
	$searchPhrase->{'auth_date'} = { -like => '%'.$c->req->param('auth_date').'%' } if ($c->req->param('auth_date'));
	return unless (defined $searchPhrase);
	$resAuth = DB->resultset('Auth')->search($searchPhrase);
	
	my $resCount = $resAuth->count;
	$resCount = 0 unless($resCount);
	
	if ($resAuth->count > 30) {
		$c->stash->{auths_count} = $resAuth->count;
		$resAuth = DB->resultset('Auth')->search($searchPhrase, {
			offset => $offset,
			rows => 30
		})
	}
	
	
	$c->stash->{auths} = $resAuth;
	$c->stash->{auths_count} = $resCount;
	$c->stash->{auth_name} = $c->req->param('auth_name');
	$c->stash->{auth_date} = $c->req->param('auth_date');
	$c->stash->{offset} = $offset;
	$c->stash->{offset_from} = $offset+1;
	$c->stash->{offset_to} = ($resCount>($offset+31)) ? $offset+31 : $resCount;
	$c->stash->{referer} = $referer;
	$c->stash->{detail}  = $c->user ? 1 : 0; # prihlasenym i detaily
	
	# same as in index()
	$c->stash->{menu} = "index";
}

sub admin_auth_cover : Local {
	my($self,$c) = @_;
	my($library,$seance,$visitor) = Obalky->visit($c);
	
	my $referer = $c->req->param('referer') || $c->req->referer;
	my $user = $c->user;
	
	unless ($user) {
    	$c->res->redirect("index");
    	return;
    }
    
    my $user_data = DB->resultset('User')->find($user->id);
	
	my $username = $user->get_column('login');	
	unless ($username eq $Obalky::ADMIN_EMAIL) {
    	$c->res->redirect("index");
    	return;
    }
    
    if ($c->req->param('del')) {
    	my $auth = DB->resultset('Auth')->find($c->req->param('del'));
    	my $abuse = DB->resultset('Abuse')->abuse_auth($auth,$auth->cover,$c->req->address,$referer,'admin_auth_cover') if ($auth);
    }
	
	my $rowsCount = 100;
	
	# paging - forward
	my $startat = 0;
	if ($c->req->param('startat')) {
		$startat = $c->req->param('startat');
		$user_data->update({ last_auth_cover => $startat });
	}
	unless ($c->req->param('startat') and $startat) {
		$startat = $user_data->get_column('last_auth_cover');
		$startat = 1 unless(defined $startat);
	}
	# paging - back
	if ($c->req->param('stepback')) {
		my $resAuthStepBack = DB->resultset('Auth')->search(
			{
				'-and' => [
					{ 'cover' => { '!=' => undef } },
					{ 'cover' => { '<' => $startat } }
				]
			},
			{
				order_by => { '-desc' => 'cover' },
				rows => $rowsCount
			});
		my $cnt;
		foreach my $row ($resAuthStepBack->all) { $startat = $row->get_column('cover'); $cnt++; }
		$startat = 1 unless(defined $startat and defined $cnt);
		$startat = 1 if($cnt < $rowsCount);
		$user_data->update({ last_auth_cover => $startat });
	}
	
	my ($resAuth,$searchPhrase) = (undef,undef);
	
	@{$searchPhrase->{'-and'}} = ();
	push @{$searchPhrase->{'-and'}}, { 'cover' => { '!=' => undef } };
	push @{$searchPhrase->{'-and'}}, { 'cover' => { '>' => $startat } } if ($startat);
	$resAuth = DB->resultset('Auth')->search($searchPhrase, {
		order_by => { '-asc' => 'cover' },
		rows => $rowsCount
	});
	
	my $resCount = DB->resultset('Auth')->search($searchPhrase)->count;
	$resCount = 0 unless($resCount);
	
	$c->stash->{auths} = $resAuth;
	$c->stash->{auths_count} = $resCount;
	$c->stash->{auths_showing} = $resAuth->count;
	$c->stash->{auths_estimate} = DB->resultset('Auth')->search($searchPhrase)->count;
	$c->stash->{startat} = $startat;
	$c->stash->{referer} = $referer;
	$c->stash->{detail}  = $c->user ? 1 : 0; # prihlasenym i detaily
	
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
 		for(qw/fullname email libcode libname libaddress libcity libpurpose
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
	$c->stash->{user_is_admin} = 0;
	$c->stash->{user_is_admin} = $c->stash->{user} eq $Obalky::ADMIN_EMAIL ? 1 : 0 if (defined $c->stash->{user});
	$c->forward('Obalky::View::TT');	
}

sub seminar : Local {
	my($self,$c) = @_;
	my $dnes = DB->resultset('Product')->search({ eshop => 109, created => {'like' => '2015-12-08%'} });
	my $vcera = DB->resultset('Product')->search({ eshop => 109, created => {'like' => '2015-12-07%'} });
	$c->stash->{vcera} = $vcera->count;
	$c->stash->{dnes} = $dnes->count;
}

#my $bibinfo = bless {}, 'Bibinfo';
#$bibinfo->{ean13} = '9788073039219';
#$bibinfo->{part_year} = 'rok 2014,2015';
#$bibinfo->{part_volume} = 'jahrg. 51(22)';
#$bibinfo->{part_no} = 'Nerozluštěné záhady 20. století';
#$bibinfo->{part_name} = " student' s  book   ";
#warn Dumper($bibinfo);
#warn Dumper(DB->resultset("Book")->normalize_bibinfo($bibinfo));

#@my $issn = Business::ISSN->new('13352720');
#$issn->fix_checksum;
#warn $issn->as_string;

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
