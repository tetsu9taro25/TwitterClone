package TwitterClone::Web::C::Message;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Message;

sub create {
  my ($class, $c, $args) = @_;

  my $user_id = $c->req->parameters->{user_id}
    or return $c->res_400;

  my $text = $c->req->parameters->{text}
    or return $c->res_400;

  my $id = TwitterClone::Repository::Message->create($user_id, $text);

  return $c->redirect("/discover");
}

sub edit {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};
  my $text = $c->req->parameters->{text} or return $c->res_400;
  my $old_text = TwitterClone::Repository::Message->fetch_by_id($id) or return $c->res_404;

  TwitterClone::Repository::Message->update($id, $text);

  return $c->redirect("/discover");
}

sub delete {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};

  TwitterClone::Repository::Message->delete($id);

  return $c->redirect("/discover");
}

1;
