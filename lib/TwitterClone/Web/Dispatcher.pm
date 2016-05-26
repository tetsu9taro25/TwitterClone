package TwitterClone::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use TwitterClone::Web::C::Discover;
use TwitterClone::Web::C::Message;
use TwitterClone::Web::C::Signup;
use TwitterClone::Web::C::Profile;
use TwitterClone::Web::C::Login;
use TwitterClone::Web::C::Logout;

base 'TwitterClone::Web::C';

get  '/'    => 'Discover#home';

get  '/discover'    => 'Discover#index';
post '/message/new'    => 'Message#create';
post '/message/:id/edit'    => 'Message#edit';
post '/message/:id/delete'    => 'Message#delete';

get '/signup'    => 'Signup#new';
post '/signup'    => 'Signup#create';

get '/profile'    => 'Profile#new';
post '/profile'    => 'Profile#update';

get '/login'    => 'Login#new';
post '/login'    => 'Login#login';

get '/logout'    => 'Logout#new';

1;
