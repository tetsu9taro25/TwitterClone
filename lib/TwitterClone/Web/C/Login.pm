package TwitterClone::Web::C::Login;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::UserData;
use TwitterClone::Repository::Login;

sub new {
  my ($class, $c, $args) = @_;
  my $user_id = $c->session->get('user_id');
  my $user_data = TwitterClone::Repository::UserData->fetch_user_profile($user_id);
  my ($screen_name, $password);
  if($user_data){
    $screen_name = $user_data->screen_name;
    $password = $user_data->password;
  }else{
    $screen_name = '';
    $password = '';
  }
  return $c->render('login.tx', {
      screen_name => $screen_name,
      password => $password,
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
  my $user_id = TwitterClone::Repository::Login->identify_user($screen_name,$password);
  if ($user_id == 0) {
    return $c->render('login.tx', {
        screen_name => $screen_name,
        password => $password,
        error_message => 'IDまたはパスワードが間違っています',
        current => 'login',
      });
  }
  $c->session->set( user_id => $user_id );
  return $c->redirect("/$screen_name");
}

1;
