package TwitterClone::Web::C::Signup;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Signup;

sub new {
  my ($class, $c, $args) = @_;

  return $c->render('signup.tx', {
    });
}

sub create {
  my ($class, $c, $args) = @_;
  my $screen_name = $c->req->parameters->{screen_name};
  my $name = $c->req->parameters->{name};
  my $password = $c->req->parameters->{password};

  TwitterClone::Repository::Signup->create($screen_name, $name, $password);

  return $c->redirect("/$screen_name");
}

1;

