package MooseX::AttributeHelpers::MethodProvider::ImmutableHash;
use Moose::Role;

our $VERSION   = '0.03';
our $AUTHORITY = 'cpan:STEVAN';

sub exists : method {
    my ($attr, $reader, $writer) = @_;    
    return sub { CORE::exists $reader->($_[0])->{$_[1]} ? 1 : 0 };
}   

sub get : method {
    my ($attr, $reader, $writer) = @_;    
    return sub {
        if ( @_ == 2 ) {
            $reader->($_[0])->{$_[1]}
        } else {
            my ( $self, @keys ) = @_;
            @{ $reader->($self) }{@keys}
        }
    };
}

sub keys : method {
    my ($attr, $reader, $writer) = @_;
    return sub { CORE::keys %{$reader->($_[0])} };        
}
     
sub values : method {
    my ($attr, $reader, $writer) = @_;
    return sub { CORE::values %{$reader->($_[0])} };        
}   

sub kv : method {
    my ($attr, $reader, $writer) = @_;
    return sub { 
        my $h = $reader->($_[0]);
        map {
            [ $_, $h->{$_} ]
        } CORE::keys %{$h} 
    };    
}
   
sub count : method {
    my ($attr, $reader, $writer) = @_;
    return sub { scalar CORE::keys %{$reader->($_[0])} };        
}

sub empty : method {
    my ($attr, $reader, $writer) = @_;
    return sub { scalar CORE::keys %{$reader->($_[0])} ? 0 : 1 };        
}

1;

__END__

=pod

=head1 NAME

MooseX::AttributeHelpers::MethodProvider::ImmutableHash
  
=head1 DESCRIPTION

This is a role which provides the method generators for 
L<MooseX::AttributeHelpers::Collection::ImmutableHash>.

=head1 METHODS

=over 4

=item B<meta>

=back

=head1 PROVIDED METHODS

=over 4

=item B<count>

=item B<empty>

=item B<exists>

=item B<get>

=item B<keys>

=item B<values>

=item B<kv>

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no 
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Stevan Little E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

