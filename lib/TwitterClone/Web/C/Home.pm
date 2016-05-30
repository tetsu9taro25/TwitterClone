package TwitterClone::Web::C::Home;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone::Repository::Home;

sub show {
  my ($class, $c) = @_;
  my @messages = TwitterClone::Repository::Home->fetch_sample_posts;

  return $c->render('index.tx', {
      messages => \@messages,
      current => 'home',
    });
}

1;
