package TwitterClone::Repository::Login;
use strict;
use warnings;
use utf8;

use TwitterClone;

sub db { TwitterClone->context->db }

sub login {
  my ($class, $screen_name, $password) = @_;
}

sub validate {
  my ($class, $screen_name, $password) = @_;
}

1;
