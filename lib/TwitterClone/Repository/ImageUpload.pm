package TwitterClone::Repository::ImageUpload;
use strict;
use warnings;
use utf8;
use Time::Piece;
use File::Copy;
use TwitterClone;

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

