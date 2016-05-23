package TwitterClone::Repository::Message;
use strict;
use warnings;
use utf8;

use TwitterClone;

sub db { TwitterClone->context->db }

sub fetch_by_id {
  my ($class, $id) = @_;

  my $row = $class->db->single(message => {id => $id});
  #return $row ? $row->text : undef;
}

sub fetch_all {
  my ($class) = @_;
  return $class->db->search('message');
}

sub create {
  my ($class, $user_id, $text) = @_;

  my $id = $class->db->fast_insert(message => {user_id => $user_id, text => $text});
  my $row = $class->db->single(message => {}, {
      columns  => [qw/id/],
      order_by => {id => 'DESC'},
    });

  return $row->id;
}

sub update {
  my ($class, $id, $text) = @_;

  $class->db->update(message => {text => $text}, {id => $id});
}
1;

