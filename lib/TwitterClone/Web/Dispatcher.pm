package TwitterClone::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use TwitterClone::Web::C::Home;
use TwitterClone::Web::C::Discover;
use TwitterClone::Web::C::ScreenName;
use TwitterClone::Web::C::Message;
use TwitterClone::Web::C::Signup;
use TwitterClone::Web::C::Profile;
use TwitterClone::Web::C::Login;
use TwitterClone::Web::C::Logout;

base 'TwitterClone::Web::C';

get  '/'    => 'Home#show';

get  '/discover'    => 'Discover#show';

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

get  '/:screen_name'    => 'ScreenName#show';
1;
