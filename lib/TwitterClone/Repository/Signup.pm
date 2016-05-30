package TwitterClone::Repository::Signup;
use strict;
use warnings;
use utf8;

use TwitterClone;

sub db { TwitterClone->context->db }

sub create {
  my ($class, $parameters) = @_;
  return $class->db->fast_insert(user => {
      screen_name => $parameters->{screen_name},
      name => $parameters->{name},
      password => $parameters->{password},
    });
}

sub validate {
  my ($class, $parameters) = @_;

  if($parameters->{screen_name} eq '' || $parameters->{name} eq '' ||  $parameters->{password} eq ''){
    $parameters->{error_message} = 'なに空文字入れて送信しとんねんボケ！';
  }

  if($class->db->single(user => {screen_name => $parameters->{screen_name}})){
    $parameters->{error_message} = '誰かとidが被ってるぜよ！';
  }

}

1;
