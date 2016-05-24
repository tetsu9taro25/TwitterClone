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
  my @messages =  $class->db->search('message',{deleted => 0},{order_by => 'created_at DESC'});
  for (my $i = 0; $i <= $#messages; $i++){
    my $date = $messages[$i]->{row_data}->{created_at};
    $date =~ s/-/年/;
    $date =~ s/-/月/;
    $date =~ s/ /日 /;
    my @list = split(/:/, $date);
    my $new_date = $list[0] . ":" .  $list[1] . "\n";
    $messages[$i]->{row_data}->{created_at} = $new_date;
  }
  return @messages;
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

sub delete {
  my ($class, $id) = @_;

  $class->db->update(message => {deleted => 1}, {id => $id});
}

1;
