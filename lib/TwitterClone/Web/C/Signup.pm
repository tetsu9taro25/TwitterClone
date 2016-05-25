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
    });
}

sub create {
  my ($class, $c, $args) = @_;
  my $screen_name = $c->req->parameters->{screen_name};
  my $name = $c->req->parameters->{name};
  my $password = $c->req->parameters->{password};

  if($screen_name eq '' || $name eq '' ||  $password eq ''){
    return $c->render('signup.tx', {
      screen_name => $screen_name,
      name => $name,
      password => $password,
      error_message => 'なに空文字入れて送信してんねんボケ！',
    });
  }

  TwitterClone::Repository::Signup->create($screen_name, $name, $password);
  return $c->redirect("/$screen_name");
}

1;

