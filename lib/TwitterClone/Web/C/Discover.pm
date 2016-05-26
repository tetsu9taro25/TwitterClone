package TwitterClone::Web::C::Discover;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Discover;

sub home {
  my ($class, $c, $args) = @_;
  return $c->render('index.tx', {
      current => 'home',
    });
}

sub index {
  my ($class, $c, $args) = @_;
  my @messages = TwitterClone::Repository::Discover->fetch_all_posts;
  my @all_user_data = TwitterClone::Repository::Discover->fetch_all_user_data;
  my $user_id = $c->session->get('user_id');
  my $user_data = TwitterClone::Repository::Discover->fetch_user_profile($user_id);
  return $c->render('login_index.tx', {
      messages => \@messages,
      all_user_data => \@all_user_data,
      user_data => $user_data,
      current => 'discover',
    });
}

1;
