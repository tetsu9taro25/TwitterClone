package TwitterClone::Repository::Signup;
use strict;
use warnings;
use utf8;

use TwitterClone;

sub db { TwitterClone->context->db }

sub create {
  my ($class, $screen_name, $name, $password) = @_;
  $class->db->insert(user => {
      screen_name => $screen_name,
      name => $name,
      password => $password,
    });
}

1;
