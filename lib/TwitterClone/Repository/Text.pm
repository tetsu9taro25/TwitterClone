package TwitterClone::Repository::Text;
use strict;
use warnings;
use utf8;

use TwitterClone;

sub db { TwitterClone->context->db }

sub fetch_by_id {
  my ($class, $id) = @_;

  my $row = $class->db->single(text => {id => $id});
  return $row ? $row->text : undef;
}

sub create {
  my ($class, $text) = @_;

  my $id = $class->db->fast_insert(text => {text => $text});
  my $row = $class->db->single(text => {}, {
      columns  => [qw/id/],
      order_by => {id => 'DESC'},
    });

  return $row->id;
}

sub update {
  my ($class, $id, $text) = @_;

  $class->db->update(text => {text => $text}, {id => $id});
}
1;
