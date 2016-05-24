package TwitterClone::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use TwitterClone::Web::C::Discover;
use TwitterClone::Web::C::Message;
use TwitterClone::Web::C::Signup;

base 'TwitterClone::Web::C';

get  '/'    => 'Discover#index';
post '/message/new'    => 'Message#create';
post '/message/:id/edit'    => 'Message#edit';
post '/message/:id/delete'    => 'Message#delete';

get '/signup'    => 'Signup#new';
post '/signup'    => 'Signup#create';

1;
