
package DB::ResultSet::FeStat;
use base 'DBIx::Class::ResultSet';

use strict;
use Data::Dumper;
use locale;
use DateTime::Format::MySQL;

my $select_requests_by_type = '
	IFNULL(SUM(cover_api_requests),0)+IFNULL(SUM(cover_requests),0)+IFNULL(SUM(etag_match),0),
	IFNULL(SUM(toc_thumbnail_api_requests),0)+IFNULL(SUM(toc_thumbnail_requests),0)+IFNULL(SUM(etag_toc_thumbnail_match),0),
	IFNULL(SUM(toc_pdf_api_requests),0)+IFNULL(SUM(toc_pdf_requests),0)+IFNULL(SUM(etag_toc_pdf_match),0),
	IFNULL(SUM(file_requests),0)+IFNULL(SUM(etag_file_match),0),
	IFNULL(SUM(meta_requests),0)';

my $select_requests_sum = '
	IFNULL(SUM(cover_api_requests),0)+IFNULL(SUM(cover_requests),0)+IFNULL(SUM(etag_match),0)+
	IFNULL(SUM(toc_thumbnail_api_requests),0)+IFNULL(SUM(toc_thumbnail_requests),0)+IFNULL(SUM(etag_toc_thumbnail_match),0)+
	IFNULL(SUM(toc_pdf_api_requests),0)+IFNULL(SUM(toc_pdf_requests),0)+IFNULL(SUM(etag_toc_pdf_match),0)+
	IFNULL(SUM(file_requests),0)+IFNULL(SUM(etag_file_match),0)+
	IFNULL(SUM(meta_requests),0)';

sub req_stats_daily {
	my($pkg,$library) = @_;
	
	return DB->resultset('FeStat')->search({ id_library=>$library }, {
		rows => 30,
		group_by => 'DATE(timestamp)',
		order_by => 'DATE(timestamp) DESC',
		'select' => \[ 'CONCAT(DATE(timestamp), " 00:00:00") AS ts,'.$select_requests_by_type ],
		'as' => ['ts', 'cover_requests', 'toc_thumbnail_requests', 'toc_pdf_requests', 'file_requests', 'meta_requests']
    });
}

sub req_stats_monthly {
	my($pkg,$library) = @_;
	
	return DB->resultset('FeStat')->search({ id_library=>$library }, {
		rows => 18,
		group_by => 'YEAR(timestamp), MONTH(timestamp)',
		order_by => 'YEAR(timestamp) DESC, MONTH(timestamp) DESC',
		'select' => \[ 'CONCAT(DATE(timestamp), " 00:00:00") AS ts,'.$select_requests_by_type ],
		'as' => ['ts', 'cover_requests', 'toc_thumbnail_requests', 'toc_pdf_requests', 'file_requests', 'meta_requests']
    });
}

sub fe_stats_daily {
	my($pkg,$library) = @_;
	
	return DB->resultset('FeStat')->search({ id_library=>$library }, {
		rows => 60,
		group_by => 'DATE(timestamp), id_fe_list',
		order_by => 'DATE(timestamp) DESC',
		'select' => \[ 'CONCAT(DATE(timestamp), " 00:00:00") AS ts, id_fe_list AS fe, '.$select_requests_sum ],
		'as' => ['ts', 'fe', 'requests']
    });
}

sub fe_stats_monthly {
	my($pkg,$library) = @_;
	
	return DB->resultset('FeStat')->search({ id_library=>$library }, {
		rows => 36,
		group_by => 'YEAR(timestamp), MONTH(timestamp), id_fe_list',
		order_by => 'YEAR(timestamp) DESC, MONTH(timestamp) DESC',
		'select' => \[ 'CONCAT(YEAR(timestamp), "-", MONTH(timestamp), "-01 00:00:00") AS ts, id_fe_list AS fe, '.$select_requests_sum ],
		'as' => ['ts', 'fe', 'requests']
    });
}

sub top_sigla_by_requests {
	my($pkg,$cnt) = @_;
	
	my $dt = DateTime->now;
	$dt->add(days => -30);
	
	my $topLibs = DB->resultset('FeStat')->search({ id_library=>{'>',50000}, timestamp=>{'>=',$dt->datetime} }, {
		rows => $cnt,
		group_by => 'me.id_library',
		order_by => '3 DESC',
		'select' => \[ '(SELECT name FROM library AS l WHERE l.id = me.id_library), me.id_library, '.$select_requests_sum ],
		'as' => ['library_name', 'id_library', 'requests']
    });
    
    my @statsData;
    my @libraryIds = ('50000');
    foreach ($topLibs->all) {
    	my $id = $_->get_column('id_library');
    	push @libraryIds, $id;
    	push @statsData, {
    		'library_name' => $_->get_column('library_name'),
    		'requests' => $_->get_column('requests')
    	}
    }
    
    my $restLibs = DB->resultset('FeStat')->search({ id_library=>{'-not_in'=>\@libraryIds}, timestamp=>{'>=',$dt->datetime} }, {
		'select' => \[ $select_requests_sum ],
		'as' => ['requests']
    })->next;
    push @statsData, {
    	'library_name' => 'Ostatni',
    	'requests' => $restLibs->get_column('requests')
    };
    
    return \@statsData;
}

1;
