package TwitterClone::Web::C::ScreenName;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone::Repository::ScreenName;

sub show {
  my ($class, $c, $args) = @_;
  my $user_id = $c->session->get('user_id') or return $c->redirect("/login");
  my $session_user_data = TwitterClone::Repository::ScreenName->fetch_user_profile($user_id);
  my @messages = TwitterClone::Repository::ScreenName->fetch_screen_name_posts($args->{screen_name});
  return $c->render('login_index.tx', {
      messages => \@messages,
      session_user_data => $session_user_data,
      current => 'home',
    });
}

1;
