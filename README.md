# NAME

Dancer::Plugin::DBIC::Sugar - Syntactical Sugar working with DBIx::Class and Dancer

# SYNOPSIS

    use Dancer::Plugin::DBIC::Sugar;
    # If Users is declared as a ResultSource
    Users->search({
      first_name => 'Bob',
    });

# DESCRIPTION

Dancer::Plugin::DBIC::Sugar is a sugary layer on top of the Dancer::Plugin::DBIC plugin.  

# AUTHOR

Sean Zellmer <sean@lejeunerenard.com>

# COPYRIGHT

Copyright 2014- Sean Zellmer

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
