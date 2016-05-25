package TwitterClone::Repository::Profile;
use strict;
use warnings;
use utf8;

use TwitterClone;

sub db { TwitterClone->context->db }

sub fetch_by_user_id {
  my ($class, $user_id) = @_;
  return $class->db->single(user => {id => $user_id});
}

sub update {
  my ($class, %params) = @_;

  $class->db->update(user => {
      name => $params{name},
      password => $params{password},
      mail => $params{mail},
      text => $params{text},
    },{ id => $params{id} }
  );
}

1;

