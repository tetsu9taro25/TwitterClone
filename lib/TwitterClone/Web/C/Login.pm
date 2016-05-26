package TwitterClone::Web::C::Login;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Login;

sub new {
  my ($class, $c, $args) = @_;

  return $c->render('login.tx', {
      screen_name => '',
      name => '',
      password => '',
      error_message => undef,
      current => 'login',
    });
}

sub login {
  my ($class, $c, $args) = @_;
  my $screen_name = $c->req->parameters->{screen_name};
  my $password = $c->req->parameters->{password};

  if($screen_name eq '' ||  $password eq ''){
    return $c->render('login.tx', {
      screen_name => $screen_name,
      password => $password,
      error_message => 'なに空文字入れて送信しとんねんボケ！',
      current => 'login',
    });
  }

  #$c->session->set(
  #  screen_name => $screen_name,
  #  password => $password,
  #);

  #print Dumper "$c->session->get('screen_name')\n";
  #TwitterClone::Repository::Login->login($screen_name, $password);
  return $c->redirect("/login");
}

1;


