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
      mention
      deleted
      created_at
      updated_at
    );
};

1;
