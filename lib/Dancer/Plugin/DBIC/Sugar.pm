package Dancer::Plugin::DBIC::Sugar;

use strict;
use warnings;
use 5.008_005;
our $VERSION = '0.01';

use Dancer ':syntax';
use Dancer::Plugin;
use Dancer::Plugin::DBIC;

# Get all the result sources
my $source_registrations = schema->source_registrations;
foreach my $source ( keys %{ $source_registrations } ) {
   # Register function by the same name
   register $source_registrations->{$source}->source_name => sub {
      return $source_registrations->{$source}->resultset;
   }
}

register_plugin;
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
