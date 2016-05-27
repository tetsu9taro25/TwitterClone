package TwitterClone::Web::C::Discover;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Discover;

sub show {
  my ($class, $c) = @_;

  my @messages = TwitterClone::Repository::Discover->fetch_all_posts;
  my $session_user_id = $c->session->get('user_id') or return $c->redirect("/login");
  my $session_user_data = TwitterClone::Repository::Discover->fetch_user_profile($session_user_id);
  return $c->render('login_index.tx', {
      messages => \@messages,
      session_user_data => $session_user_data,
      current => 'discover',
    });
  #print Dumper @messages;
}

1;
