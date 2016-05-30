package TwitterClone::Repository::Mention;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;
use TwitterClone::Repository::Helper;

sub db { TwitterClone->context->db }

sub fetch_screen_name_posts {
  my ($class, $user_id) = @_;

  my @mentioned_messages = $class->db->search('mention',{
      mention => $user_id,
    });
  my @mentioned_message_id;
  for(@mentioned_messages){
    push(@mentioned_message_id,$_->message_id);
  }

  if(@mentioned_message_id==0){
    push(@mentioned_message_id,0);
  }

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
    where message.id in :ids and message.deleted = :num
    order by created_at desc}, {
      ids => [@mentioned_message_id],
      num => 0,
    });

  my @messages = $itr->all;
  TwitterClone::Repository::Helper->parse(@messages);
  return @messages;
}

1;
