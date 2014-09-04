package Schema::Result::Post;
use base 'DBIx::Class::Core';
use strict;
use warnings;

__PACKAGE__->table("post");
__PACKAGE__->add_columns(
   id => {
      data_type => 'integer',
      is_auto_increment => 1,
   },
   title => {
      data_type => "varchar",
   },
);
__PACKAGE__->set_primary_key("id");

1;
