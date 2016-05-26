package TwitterClone::Web::C::Profile;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Profile;

sub new {
  my ($class, $c, $args) = @_;
  my $user_id = $c->session->get('user_id') or return $c->redirect("/login");
  my $user_data = TwitterClone::Repository::Profile->fetch_by_user_id($user_id);

  return $c->render('profile.tx', {
      user_data => $user_data,
      error_message => undef,
      current => 'profile',
    });
}

sub update {
  my ($class, $c, $args) = @_;
  my $user_id = $c->session->get('user_id') or return $c->redirect("/login");
  my $user_data = TwitterClone::Repository::Profile->fetch_by_user_id($user_id);
  my $image_path = TwitterClone::Repository::Profile->image_upload($c->req->uploads->{'image'}, $c->base_dir());

  my %user_data = (
    screen_name => $user_data->screen_name,
    id => $user_id,
    name => $c->req->parameters->{name},
    password => $c->req->parameters->{password},
    mail => $c->req->parameters->{mail},
    text => $c->req->parameters->{text},
    image => $image_path,
  );

  if($user_data{name} eq '' ||  $user_data{password} eq ''){
    return $c->render('profile.tx', {
      user_data => \%user_data,
      error_message => '必須やゆうてんのに、なに空文字入れて送信しとんねんボケ！',
      current => 'profile',
    });
  }

  TwitterClone::Repository::Profile->update(%user_data);
  return $c->redirect("/discover"); #セッションから引っ張ってくる
}

1;
