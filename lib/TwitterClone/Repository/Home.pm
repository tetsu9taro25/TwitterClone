package TwitterClone::Repository::Home;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;
use TwitterClone::Repository::Helper;

sub db { TwitterClone->context->db }

sub fetch_sample_posts {
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
    where user.image is not null and message.image is not null and message.deleted = :num
    order by created_at desc}, {num => 0});
  my @messages = $itr->next;
  TwitterClone::Repository::Helper->parse(@messages);
  return @messages;
}

1;
