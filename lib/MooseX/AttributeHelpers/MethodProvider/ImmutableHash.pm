package MooseX::AttributeHelpers::MethodProvider::ImmutableHash;
use Moose::Role;

our $VERSION = '0.26';

sub exists : method {
    my ($attr, $reader, $writer) = @_;
    return sub { CORE::exists $reader->($_[0])->{$_[1]} ? 1 : 0 };
}

sub defined : method {
    my ($attr, $reader, $writer) = @_;
    return sub { CORE::defined $reader->($_[0])->{$_[1]} ? 1 : 0 };
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

sub elements : method {
    my ($attr, $reader, $writer) = @_;
    return sub {
        my $h = $reader->($_[0]);
        map {
            $_, $h->{$_}
        } CORE::keys %{$h}
    };
}

sub count : method {
    my ($attr, $reader, $writer) = @_;
    return sub { scalar CORE::keys %{$reader->($_[0])} };
}

sub empty : method {
    my ($attr, $reader, $writer) = @_;
    return sub { scalar CORE::keys %{$reader->($_[0])} ? 1 : 0 };
}

1;

__END__

=pod

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

Returns the number of elements in the list.

=item B<empty>

If the list is populated, returns true. Otherwise, returns false.

=item B<exists>

Returns true if the given key is present in the hash

=item B<defined>

Returns true if the value of a given key is defined

=item B<get>

Returns an element of the hash by its key.

=item B<keys>

Returns the list of keys in the hash.

=item B<values>

Returns the list of values in the hash.

=item B<kv>

Returns the key, value pairs in the hash as array references

=item B<elements>

Returns the key, value pairs in the hash as a flattened list

=back

=cut
