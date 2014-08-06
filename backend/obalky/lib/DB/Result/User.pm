use utf8;
package DB::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::User

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 login

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 fullname

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 library

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 eshop

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 flag_library_admin

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 flag_review_report

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "login",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "fullname",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "library",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "eshop",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "flag_library_admin",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "flag_review_report",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<user_login>

=over 4

=item * L</login>

=back

=cut

__PACKAGE__->add_unique_constraint("user_login", ["login"]);

=head1 RELATIONS

=head2 eshop

Type: belongs_to

Related object: L<DB::Result::Eshop>

=cut

__PACKAGE__->belongs_to(
  "eshop",
  "DB::Result::Eshop",
  { id => "eshop" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 library

Type: belongs_to

Related object: L<DB::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library",
  "DB::Result::Library",
  { id => "library" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 uploads

Type: has_many

Related object: L<DB::Result::Upload>

=cut

__PACKAGE__->has_many(
  "uploads",
  "DB::Result::Upload",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-10 23:42:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+hx+bpae9copEM3c+pFAsw


use Data::Dumper;

sub find_by_email {
	my($pkg,$email) = @_;
	die "Neplatný e-mail '$email'.\n" unless $email =~ /\@.+\..+/;
	my($user,$more) = $pkg->search({ login => $email });
	return $user;
}

sub resetpassword {
	my($pkg,$email,$password) = @_;
}

sub sendpassword {
	my($pkg,$email) = @_;
	die "Uživatel s e-mailovou adresou <a href=\"mailto:$email\">$email</a>".
			" nebyl v systému nalezen.\n" unless $pkg->find_by_email($email);

	# FIX: send e-mail

	$email = 'martin@sarfy.cz';
	open(MUTT,"| mutt -s 'obalkyknih.cz -- vyresetovani hesla' '$email'");
	print MUTT <<EOF;

Jen test..

EOF
	close(MUTT);
	return 1;
}

sub signup_RS {
	my($pkg,$hash,$model) = @_; 
	my $login = $hash->{email};

	my @errors;

	push @errors, "Není vyplněno plné jméno uživatele."
		if(not $hash->{fullname} or $hash->{fullname} !~ /\s/);

	push @errors, "Neplatný e-mail '$login'.\n" unless $login =~ /\@.+\..+/;

	push @errors, "Uživatel s e-mailem <a href=\"mailto:$login\">$login</a>".
			" už v systému existuje."  if($pkg->find($login));
	
	push @errors, "Není vyplněno heslo." unless($hash->{password1});
	push @errors, "Zadaná hesla se liší." 
		if($hash->{password1} ne $hash->{password2});

	my $libcode = $hash->{libcode};
	push @errors, "Není vyplněna sigla knihovny."
		unless($libcode);

	push @errors, "Není vyplněn název knihovny."
		unless($hash->{libname});

	push @errors, "Neplatná URL adresa webového katalogu."
		unless($hash->{libopac} =~ /^http\:\/\/.+\..+$/);

	push @errors, "Neplatná URL adresa XML feedu." if($hash->{xmlfeed} 
				and $hash->{xmlfeed} !~ /^http\:\/\/.+\..+$/);

	my $user;

	unless(@errors) {
	# fullname, email, password1, password2, libcode, libname, libopac

		my $library = DB->resultset('Library')->find($libcode);
		$library = DB->resultset('Library')->create(
						{ code => $libcode }) unless($library);

		unless($library) {
			push @errors, "Interní chyba: Nelze vytvořit knihovnu '$libcode'."

		} else {

			$library->name($hash->{libname});
			$library->webopac($hash->{libopac});
			$library->update;

			eval { $user = $pkg->create({
				login => $login, fullname => $hash->{fullname},
				password => $hash->{password1}, library => $library
			}) };

			push @errors, $@ if $@;
			push @errors, "Interní chyba: Nelze vytvořit uživatele '$login'."
					unless($user);
		}
	}

	if(@errors) {
		die $errors[0]."\n" if(@errors == 1);
		die "<ul>".(join("\n",map "<li>$_</li>", @errors))."</ul>\n";
	}

	return $user;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
