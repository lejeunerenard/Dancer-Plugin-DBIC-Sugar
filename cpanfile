requires 'perl', '5.008005';
requires 'Dancer::Plugin::DBIC';

# requires 'Some::Module', 'VERSION';

on test => sub {
    requires 'Test::More', '0.96';
    requires 'Test::DBIx::Class';
};
