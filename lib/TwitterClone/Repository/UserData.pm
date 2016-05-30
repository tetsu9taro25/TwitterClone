package TwitterClone::Repository::UserData;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;

sub db { TwitterClone->context->db }

sub fetch_user_profile {
  my ($class, $user_id) = @_;
  return $class->db->single(user => {id => $user_id});
}

1;

