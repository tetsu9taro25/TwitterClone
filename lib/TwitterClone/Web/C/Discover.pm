package TwitterClone::Web::C::Discover;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use TwitterClone::Repository::Discover;

sub index {
  my ($class, $c, $args) = @_;
  my @messages = TwitterClone::Repository::Discover->fetch_all;
  return $c->render('index.tx', {
      messages => \@messages,
    });
}

1;
