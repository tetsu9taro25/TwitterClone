package TwitterClone::Repository::Message;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;

sub db { TwitterClone->context->db }

sub fetch_by_id {
  my ($class, $message_id) = @_;

  my $row = $class->db->single(message => {id => $message_id});
  return $row ? $row : undef;
}

sub create {
  my ($class, $user_id, $text) = @_;

  my $message_id = $class->db->fast_insert(message => {user_id => $user_id, text => $text});

  return $message_id;
}

sub update {
  my ($class, $message_id, $text) = @_;

  $class->db->update(message => {text => $text}, {id => $message_id});
}

sub delete {
  my ($class, $message_id) = @_;

  $class->db->update(message => {deleted => 1}, {id => $message_id});
}

sub validate {
  my ($class, $user_id, $writer) = @_;
  return $user_id == $writer ? 1 : undef;
}

1;
