#!/usr/bin/perl

# gimap.pl by gxmsgx
# description: get the count of unread messages on gmail imap

use strict;
use Mail::IMAPClient;
use IO::Socket::SSL;

my ($username, $password) = @ARGV;

my $socket = IO::Socket::SSL->new(
   PeerAddr => 'imap.gmail.com',
   PeerPort => 993,
  )
  or die "socket(): $@";

my $client = Mail::IMAPClient->new(
   Socket   => $socket,
   User     => $username,
   Password => $password,
  )
  or die "new(): $@";

if ($client->IsAuthenticated()) {
    my $msgct = 1;
    
    $client->select("INBOX");

    my @unread = $client->unseen or warn "Could not find unseen msgs: $@\n";
    my $msg;
    
    foreach my $id ( @unread ) {
        $msg .= $msgct++.") ".$client->subject($id)."\n";
 	
        if($msgct == 7) {last};
    }
    print "\${color green}".$username."\${color red}(" .$client->unseen_count." new) \${color lightgrey}\${hr}\n\n";
    print $msg;
}

$client->logout();
