package TwitterClone::Repository::Profile;
use strict;
use warnings;
use utf8;
use TwitterClone;

sub db { TwitterClone->context->db }

sub update {
  my ($class, %params) = @_;

  $class->db->update(user => {
      name => $params{name},
      password => $params{password},
      mail => $params{mail},
      text => $params{text},
    },{ id => $params{id} }
  );
  if($params{image}){
    $class->db->update(user => {
        image => $params{image},
      },{ id => $params{id} }
    );
  }
}

1;

