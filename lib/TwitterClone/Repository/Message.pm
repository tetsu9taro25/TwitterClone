package TwitterClone::Repository::Message;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;

sub db { TwitterClone->context->db }

sub fetch_by_id {
  my ($class, $id) = @_;

  my $row = $class->db->single(message => {id => $id});
  return $row ? $row->text : undef;
}

sub create {
  my ($class, $user_id, $text) = @_;

  my $id = $class->db->fast_insert(message => {user_id => $user_id, text => $text});

  return $id;
}

sub update {
  my ($class, $id, $text) = @_;

  $class->db->update(message => {text => $text}, {id => $id});
}

sub delete {
  my ($class, $id) = @_;

  $class->db->update(message => {deleted => 1}, {id => $id});
}

1;
