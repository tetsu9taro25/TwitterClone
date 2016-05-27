package TwitterClone::Web::C::Home;
use strict;
use warnings;
use utf8;
use Data::Dumper;

sub show {
  my ($class, $c) = @_;
  return $c->render('index.tx', {
      current => 'home',
    });
}

1;
