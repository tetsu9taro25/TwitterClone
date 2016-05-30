package TwitterClone::Web::C::Logout;
use strict;
use warnings;
use utf8;
use Data::Dumper;

sub new {
  my ($class, $c) = @_;
  #my $user_id = $c->session->get('user_id');
  $c->session->remove('user_id');
  return $c->redirect("/");
}

1;

