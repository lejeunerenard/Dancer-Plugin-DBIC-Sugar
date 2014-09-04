use strict;
use warnings;

use lib qw{ ./t/lib };

use Test::More tests => 1;
use Test::Deep; # (); # uncomment to stop prototype errors
use Test::Exception;

use Dancer qw(:syntax :tests);
use Dancer::Plugin::DBIC::Sugar;

eval { require DBD::SQLite };
plan skip_all => 'DBD::SQLite required to run these tests' if $@;

set plugins => {
   DBIC => {
      foo => {
         schema_class => 'Schema',
         dsn =>  'dbi:SQLite:dbname=:memory:',
      },
   }
};

schema->deploy;

subtest 'ResultSets are exported' => sub {
   plan tests => 6;
   can_ok('main','User');
   can_ok('main','Post');

   isa_ok(User(), 'DBIx::Class::ResultSet');
   isa_ok(Post(), 'DBIx::Class::ResultSet');

   is User()->result_class->table, 'user', 'User is using the correct table';
   is Post()->result_class->table, 'post', 'Post is using the correct table';
};
