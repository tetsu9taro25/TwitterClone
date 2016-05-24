package TwitterClone::Repository::Discover;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;

sub db { TwitterClone->context->db }

sub fetch_all {
  my ($class) = @_;
  my @messages =  $class->db->search('message',{deleted => 0},{order_by => 'created_at DESC'});
  $class->parse(@messages);
  return @messages;
}

sub parse {
  my ($class, @messages) = @_;

  for (my $i = 0; $i <= $#messages; $i++){
    my $date = $messages[$i]->{row_data}->{created_at};
    $date =~ s/-/年/;
    $date =~ s/-/月/;
    $date =~ s/ /日 /;
    my @list = split(/:/, $date);
    my $new_date = $list[0] . ":" .  $list[1] . "\n";
    $messages[$i]->{row_data}->{created_at} = $new_date;
  }
}

1;
