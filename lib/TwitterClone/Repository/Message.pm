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
  my ($class, $user_id, $text, $image_path, @mention_ids) = @_;

  my $message_id = $class->db->fast_insert(message => {
      user_id => $user_id,
      text => $text,
      image => $image_path,
    });

  for(@mention_ids){
    $class->db->fast_insert(mention => {
        message_id => $message_id,
        mention => $_,
      });
  }

  return $message_id;
}

sub update {
  my ($class, $message_id, $text, $image_path, @mention_ids) = @_;

  if($image_path){
    $class->db->update(message => {
        text => $text,
        image => $image_path,
      }, {id => $message_id});
  }else{
    $class->db->update(message => {
        text => $text,
      }, {id => $message_id});
  }

  $class->db->delete('mention', {
      message_id => $message_id
    });
  for(@mention_ids){
    $class->db->fast_insert(mention => {
        message_id => $message_id,
        mention => $_,
      });
  }
}

sub delete {
  my ($class, $message_id) = @_;

  $class->db->update(message => {deleted => 1}, {id => $message_id});
}

sub validate {
  my ($class, $user_id, $writer) = @_;
  return $user_id == $writer ? 1 : undef;
}

sub fetch_screen_name {
  my ($class, $user_id) = @_;
  my $row = $class->db->single(user => {id => $user_id});
  return $row->screen_name;
}

sub redirect_to {
  my ($class, $ref, $screen_name) = @_;
  if($ref =~ m|mentions|){ $ref = $screen_name;}
  return $ref;
}

sub check_mention {
  my ($class, $text) = @_;
  my @segments = split(/\s/, $text);
  my @ids;
  for (@segments) {
    if($_ =~ /^@/){
      $_ =~ s/@//;
      my $row = $class->db->single(user => {screen_name => $_});
      push(@ids, $row->id);
    }
  }
  return @ids;
}

1;
