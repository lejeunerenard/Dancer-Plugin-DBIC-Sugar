package Dancer::Plugin::DBIC::Sugar;

use strict;
use warnings;
use 5.008_005;
our $VERSION = '0.02';

use Dancer ':syntax';
use Dancer::Plugin;
use Dancer::Plugin::DBIC;
our @ISA = qw(Exporter);
our @EXPORT;
{
   no strict 'refs';
   @EXPORT = @{"Dancer::Plugin::DBIC::EXPORT"};
}

# To get the Resulsets subs without necessitating the import of this
# module after the config is loaded, we have to overwrite
# Dancer::Plugin::DBIC's schema sub with our own to get the Resultsets
# after the schema has been loaded. Once we get the ResultSets we can
# register the functions of this module and export them.
my $old_schema = \&schema;
{
   no warnings 'redefine';
   *schema = sub {
      my $old_schema_return = &$old_schema(@_);

      # Get all the result sources
      my $source_registrations = $old_schema_return->source_registrations;
      foreach my $source ( keys %{ $source_registrations } ) {
         # Register function by the same name
         register $source_registrations->{$source}->source_name => sub {
            return $source_registrations->{$source}->resultset;
         }
      }

      # Delayed register
      register_plugin;

      # Now pump all the exportable functions up the chain AKA 1 level
      __PACKAGE__->export_to_level(1, undef, @EXPORT);
      # So that schema still works as normal
      return $old_schema_return;
   };
}

1;
__END__

=encoding utf-8

=head1 NAME

Dancer::Plugin::DBIC::Sugar - Syntactical Sugar working with DBIx::Class and Dancer

=head1 SYNOPSIS

  use Dancer::Plugin::DBIC::Sugar;
  # If Users is declared as a ResultSource
  Users->search({
    first_name => 'Bob',
  });

=head1 DESCRIPTION

Dancer::Plugin::DBIC::Sugar is a sugary layer on top of the Dancer::Plugin::DBIC plugin.  

=head1 AUTHOR

Sean Zellmer E<lt>sean@lejeunerenard.comE<gt>

=head1 COPYRIGHT

Copyright 2014- Sean Zellmer

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
