package TwitterClone::Web::C::Profile;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Profile;

sub new {
  my ($class, $c, $args) = @_;
  my $user_id = 3; #セッションから引っ張ってくる
  my $user_data = TwitterClone::Repository::Profile->fetch_by_user_id($user_id);

  return $c->render('profile.tx', {
      user_data => $user_data,
      error_message => undef,
      current => 'profile',
    });
}

sub update {
  my ($class, $c, $args) = @_;
  my %user_data = (
    screen_name => 'fa',#セッションから引っ張ってくる
    id => 3, #セッションから引っ張ってくる
    name => $c->req->parameters->{name},
    password => $c->req->parameters->{password},
    mail => $c->req->parameters->{mail},
    text => $c->req->parameters->{text},
  );
  if($user_data{name} eq '' ||  $user_data{password} eq ''){
    return $c->render('profile.tx', {
      user_data => \%user_data,
      error_message => '必須やゆうてんのに、なに空文字入れて送信しとんねんボケ！',
      current => 'profile',
    });
  }
  TwitterClone::Repository::Profile->update(%user_data);
  return $c->redirect("/profile"); #セッションから引っ張ってくる
}

1;


