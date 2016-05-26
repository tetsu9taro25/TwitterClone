package TwitterClone::Repository::Profile;
use strict;
use warnings;
use utf8;
use Time::Piece;
use File::Copy;
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
  if($params{image}){
    $class->db->update(user => {
        image => $params{image},
      },{ id => $params{id} }
    );
  }
}

sub image_upload {
  my ($class, $upload, $base) = @_;

  if($upload){
    my $ext = $class->valid_type($upload->content_type);
    if($ext){
      my $src = $upload->tempname;
      my $raw_dst = $class->create_filename($ext);
      $base =~ s/script\/\.\./static\/img/;
      my $dst = File::Spec->catfile($base, $raw_dst);
      copy $src, $dst;
      return $raw_dst;
    }
  }
}

sub valid_type {
  my ($class, $type) = @_;

  my %valid_types = ('image/gif' => 'gif','image/jpeg' => 'jpg','image/png' => 'png');

  return $valid_types{$type};
}

sub create_filename {
  my ($class, $ext) = @_;

  my $date = localtime;
  my $rand_num = sprintf "%05s",int(rand 100000);
  return 'image-'.$date->datetime(date => '',time => '',T => '').'-'.$rand_num.'.'.$ext;
}

1;

