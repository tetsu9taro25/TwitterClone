package TwitterClone::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use TwitterClone::Web::C::Page;

base 'TwitterClone::Web::C';

get  '/'    => 'Page#get_root';
post '/message/new'    => 'Page#post_new';
post '/message/:id/edit'    => 'Page#post_id_edit';
post '/message/:id/delete'    => 'Page#post_id_delete';
get '/signup'    => 'Page#get_signup';

1;
