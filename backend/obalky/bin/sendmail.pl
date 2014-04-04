#!/usr/bin/perl -w

use Mail::Sender;

my $sender = new Mail::Sender { from => 'noreply@obalkyknih.cz'};
$sender->MailFile({ to => 'martin@sarfy.cz',
  subject => 'Here is the file',
  msg => "I'm sending you the list you wanted.",
  file => 'sendmail.pl'});

