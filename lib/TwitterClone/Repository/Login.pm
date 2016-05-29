package TwitterClone::Repository::Login;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone;

sub db { TwitterClone->context->db }

sub identify_user {
  my ($class, $screen_name, $password) = @_;

  my $user_data = $class->db->single('user',{
      screen_name => $screen_name,
      password => $password,
    });

  return 0 if(!$user_data);
  return $user_data->id;
}

1;
