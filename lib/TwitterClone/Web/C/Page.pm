package TwitterClone::Web::C::Page;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Message;

sub get_root {
  my ($class, $c, $args) = @_;
  my @messages = TwitterClone::Repository::Message->fetch_all;

  return $c->render('index.tx', {
      messages => \@messages,
    });
}

sub post_new {
  my ($class, $c, $args) = @_;

  my $user_id = $c->req->parameters->{user_id}
    or return $c->res_400;

  my $text = $c->req->parameters->{text}
    or return $c->res_400;

  my $id = TwitterClone::Repository::Message->create($user_id, $text);

  return $c->redirect("/");
}

sub post_id_edit {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};
  my $text = $c->req->parameters->{text} or return $c->res_400;
  my $old_text = TwitterClone::Repository::Message->fetch_by_id($id) or return $c->res_404;

  TwitterClone::Repository::Message->update($id, $text);

  return $c->redirect("/");
}

sub post_id_delete {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};

  TwitterClone::Repository::Message->delete($id);

  return $c->redirect("/");
}

sub get_signup {
  my ($class, $c, $args) = @_;

  return $c->render('signup.tx', {
    });
}

1;
