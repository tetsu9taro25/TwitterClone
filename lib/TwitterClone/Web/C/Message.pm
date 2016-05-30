package TwitterClone::Web::C::Message;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Message;
use TwitterClone::Repository::ImageUpload;

sub create {
  my ($class, $c, $args) = @_;

  my $user_id = $c->session->get('user_id')
    or return $c->redirect("/login");
  my $screen_name = TwitterClone::Repository::Message->fetch_screen_name($user_id);
  my $text = $c->req->parameters->{text}
    or return $c->res_404;
  my $image_path = TwitterClone::Repository::ImageUpload->image_upload($c->req->uploads->{'image'}, $c->base_dir());
  my @mention_ids = TwitterClone::Repository::Message->check_mention($text);

  my $message_id = TwitterClone::Repository::Message->create($user_id, $text, $image_path, @mention_ids);
  return $c->redirect($c->req->headers->referer);
}

sub edit {
  my ($class, $c, $args) = @_;
  my $message_id = $args->{id};
  my $user_id = $c->session->get('user_id') or return $c->redirect("/login");
  my $screen_name = TwitterClone::Repository::Message->fetch_screen_name($user_id);
  my $old_message = TwitterClone::Repository::Message->fetch_by_id($message_id) or return $c->res_404;
  TwitterClone::Repository::Message->validate($user_id, $old_message->user_id) or return $c->res_403;
  my $text = $c->req->parameters->{text} or return $c->res_404;
  my $image_path = TwitterClone::Repository::ImageUpload->image_upload($c->req->uploads->{'image'}, $c->base_dir());
  my @mention_ids = TwitterClone::Repository::Message->check_mention($text);

  TwitterClone::Repository::Message->update($message_id, $text, $image_path, @mention_ids);
  return $c->redirect($c->req->headers->referer);
}

sub delete {
  my ($class, $c, $args) = @_;
  my $message_id = $args->{id};
  my $user_id = $c->session->get('user_id') or return $c->redirect("/login");
  my $screen_name = TwitterClone::Repository::Message->fetch_screen_name($user_id);
  my $old_message = TwitterClone::Repository::Message->fetch_by_id($message_id) or return $c->res_404;
  TwitterClone::Repository::Message->validate($user_id, $old_message->user_id) or return $c->res_403;

  TwitterClone::Repository::Message->delete($message_id);
  return $c->redirect($c->req->headers->referer);
}

1;
