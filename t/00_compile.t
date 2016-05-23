use strict;
use warnings;
use Test::More;


use TwitterClone;
use TwitterClone::Web;
use TwitterClone::Web::View;
use TwitterClone::Web::ViewFunctions;

use TwitterClone::DB::Schema;
use TwitterClone::Web::Dispatcher;


pass "All modules can load.";

done_testing;
