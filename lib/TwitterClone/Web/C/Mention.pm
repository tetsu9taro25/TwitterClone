package TwitterClone::Web::C::Mention;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Mention;

sub show {
  my ($class, $c, $args) = @_;
  my $user_id = $c->session->get('user_id') or return $c->redirect("/login");
  my $session_user_data = TwitterClone::Repository::Mention->fetch_user_profile($user_id);
  my @messages = TwitterClone::Repository::Mention->fetch_screen_name_posts($user_id);
  return $c->render('login_index.tx', {
      messages => \@messages,
      session_user_data => $session_user_data,
      current => 'mentions',
    });
}

1;

