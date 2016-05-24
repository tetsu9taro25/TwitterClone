package TwitterClone::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use TwitterClone::Web::C::Page;

base 'TwitterClone::Web::C';

get  '/'    => 'Page#get_root';
post '/message/new'    => 'Page#post_root';
post '/:id/edit'    => 'Page#post_id';

1;
