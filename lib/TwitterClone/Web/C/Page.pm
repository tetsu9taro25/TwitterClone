package TwitterClone::Web::C::Page;
use strict;
use warnings;
use utf8;

use TwitterClone::Repository::Message;

sub get_root {
  my ($class, $c, $args) = @_;
  my @messages = TwitterClone::Repository::Message->fetch_all;

  return $c->render('index.tx', {
      action => '/',
      messages => \@messages,
    });
}

sub post_root {
  my ($class, $c, $args) = @_;

  my $user_id = $c->req->parameters->{user_id}
    or return $c->res_400;

  my $text = $c->req->parameters->{text}
    or return $c->res_400;

  my $id = TwitterClone::Repository::Message->create($user_id, $text);

  return $c->redirect("/");
}

1;
