use inc::Module::Install;

name 'Obalky';
all_from 'lib/Obalky.pm';

requires 'YAML'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

requires 'Catalyst' => '5.7003';
requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Unicode';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::View::TT';
requires 'Cache::FastMmap';
requires 'Data::Structure::Util'; # mozna ne..
requires 'Date::Simple';
requires 'Template';
requires 'Template::Timer';
requires 'DBIx::Class::Schema::Loader';
requires 'DBIx::Class';
requires 'DBD::mysql';
requires 'MD5';
requires 'HTML::TreeBuilder::XPath';
requires 'HTML::Tiny';
requires 'IO::Scalar';
requires 'Business::ISBN';
requires 'FCGI';
requires 'List::MoreUtils';
requires 'DateTime::Format::MySQL';
requires 'DateTime::Format::ISO8601';
requires 'XML::LibXML';
requires 'Text::CSV::Encoded';
requires 'Test::Pod::Coverage';
requires 'DBIx::Class::TimeStamp';
requires 'Net::OAI::Harvester';
requires 'XML::Simple';
requires 'ZOOM';
requires 'Digest::SHA1';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
