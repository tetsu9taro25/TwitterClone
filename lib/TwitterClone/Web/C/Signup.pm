package TwitterClone::Web::C::Signup;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Signup;

sub new {
  my ($class, $c, $args) = @_;

  return $c->render('signup.tx', {
      screen_name => '',
      name => '',
      password => '',
      error_message => undef,
      current => 'signup',
    });
}

sub create {
  my ($class, $c, $args) = @_;
  my %parameters = (
    screen_name => $c->req->parameters->{screen_name},
    name => $c->req->parameters->{name},
    password => $c->req->parameters->{password},
    error_message => undef,
    current => 'signup',
  );

  TwitterClone::Repository::Signup->validate(\%parameters);
  if($parameters{'error_message'}){
    return $c->render('signup.tx', \%parameters);
  }

  my $user_id = TwitterClone::Repository::Signup->create(\%parameters);
  print Dumper $user_id. "\n";
  $c->session->set( user_id => $user_id );
  return $c->redirect("/" . $parameters{'screen_name'});
}

1;
