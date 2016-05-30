package TwitterClone::Repository::Discover;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;
use TwitterClone::Repository::Helper;

sub db { TwitterClone->context->db }

sub fetch_all_posts {
  my ($class) = @_;

  my $itr = $class->db->search_named(q{select
    message.id,
    message.user_id,
    message.text,
    message.image as message_image,
    message.deleted,
    message.created_at,
    user.screen_name,
    user.name,
    user.image as user_image
    from message inner join user on message.user_id = user.id
    where message.deleted = :num
    order by created_at desc}, {num => 0});
  my @messages = $itr->all;
  TwitterClone::Repository::Helper->parse(@messages);
  return @messages;
}

1;
