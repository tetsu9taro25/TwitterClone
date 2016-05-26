package TwitterClone::Web::C::Message;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Message;

sub create {
  my ($class, $c, $args) = @_;

  my $user_id = $c->session->get('user_id')
    or return $c->redirect("/login");

  my $text = $c->req->parameters->{text}
    or return $c->res_404;

  my $id = TwitterClone::Repository::Message->create($user_id, $text);

  return $c->redirect("/discover");
}

sub edit {
  my ($class, $c, $args) = @_;
  my $message_id = $args->{id};
  my $user_id = $c->session->get('user_id') or return $c->redirect("/login");
  my $old_message = TwitterClone::Repository::Message->fetch_by_id($message_id) or return $c->res_404;
  TwitterClone::Repository::Message->validate($user_id, $old_message->user_id) or return $c->res_403;

  my $text = $c->req->parameters->{text} or return $c->res_404;
  TwitterClone::Repository::Message->update($message_id, $text);

  return $c->redirect("/discover");
}

sub delete {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};

  TwitterClone::Repository::Message->delete($id);

  return $c->redirect("/discover");
}

1;
