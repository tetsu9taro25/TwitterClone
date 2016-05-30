package TwitterClone::Repository::Helper;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;

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
