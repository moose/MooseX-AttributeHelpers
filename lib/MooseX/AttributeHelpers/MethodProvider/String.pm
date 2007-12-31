
package MooseX::AttributeHelpers::MethodProvider::String;
use Moose::Role;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

sub append : method { 
    my ($attr, $reader, $writer) = @_;

    return sub { $writer->( $_[0],  $reader->($_[0]) . $_[1] ) };
}

sub prepend : method {
    my ($attr, $reader, $writer) = @_;

    return sub { $writer->( $_[0],  $_[1] . $reader->($_[0]) ) };
}

sub replace : method {
    my ($attr, $reader, $writer) = @_;

    return sub {
        my ( $self, $regex, $replacement ) = @_;
        my $v = $reader->($_[0]);

        if ( (ref($replacement)||'') eq 'CODE' ) {
            $v =~ s/$regex/$replacement->()/e;
        } else {
            $v =~ s/$regex/$replacement/;
        }

        $writer->( $_[0], $v);
    };
}

sub match : method {
    my ($attr, $reader, $writer) = @_;
    return sub { $reader->($_[0]) =~ $_[1] };
}

sub chop : method {
    my ($attr, $reader, $writer) = @_;
    return sub {
        my $v = $reader->($_[0]);
        CORE::chop($v);
        $writer->( $_[0], $v);
    };
}

sub chomp : method {
    my ($attr, $reader, $writer) = @_;
    return sub {
        my $v = $reader->($_[0]);
        chomp($v);
        $writer->( $_[0], $v);
    };
}

sub inc : method {
    my ($attr, $reader, $writer) = @_;
    return sub {
        my $v = $reader->($_[0]);
        $v++;
        $writer->( $_[0], $v);
    };
}

sub clear : method {
    my ($attr, $reader, $writer ) = @_;
    return sub { $writer->( $_[0], '' ) }
}

1;

__END__

=pod

=head1 NAME

MooseX::AttributeHelpers::MethodProvider::String
  
=head1 DESCRIPTION

This is a role which provides the method generators for 
L<MooseX::AttributeHelpers::String>.

=head1 METHODS

=over 4

=item B<meta>

=back

=head1 PROVIDED METHODS

=over 4

=item B<append>

=item B<prepend>

=item B<replace>

=item B<match>

=item B<chomp>

=item B<chop>

=item B<inc>

=item B<clear>

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no 
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Stevan Little E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut