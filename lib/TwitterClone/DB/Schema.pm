package TwitterClone::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'TwitterClone::DB::Row';

table {
  name 'message';
  pk 'id';
  columns qw(
  id
  user_id
  text
  image
  deleted
  created_at
  updated_at
  );
};

table {
  name 'user';
  pk 'id';
  columns qw(
  id
  screen_name
  name
  password
  mail
  text
  image
  deleted
  created_at
  updated_at
  );
};

table {
  name 'follow';
  pk 'id';
  columns qw(
  id
  user_id
  follow_user_id
  created_at
  );
};

table {
  name 'mention';
  pk 'id';
  columns qw(
  id
  message_id
  mention
  );
};

1;
