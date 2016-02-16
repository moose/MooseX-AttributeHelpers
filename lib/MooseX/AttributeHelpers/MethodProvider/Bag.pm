package MooseX::AttributeHelpers::MethodProvider::Bag;
use Moose::Role;

our $VERSION = '0.25';

with 'MooseX::AttributeHelpers::MethodProvider::ImmutableHash';

sub add : method {
    my ($attr, $reader, $writer) = @_;
    return sub { $reader->($_[0])->{$_[1]}++ };
}

sub delete : method {
    my ($attr, $reader, $writer) = @_;
    return sub { CORE::delete $reader->($_[0])->{$_[1]} };
}

sub reset : method {
    my ($attr, $reader, $writer) = @_;
    return sub { $reader->($_[0])->{$_[1]} = 0 };
}

1;

__END__

=pod

=head1 DESCRIPTION

This is a role which provides the method generators for
L<MooseX::AttributeHelpers::Collection::Bag>.

This role is composed from the 
L<MooseX::AttributeHelpers::Collection::ImmutableHash> role.

=head1 METHODS

=over 4

=item B<meta>

=back

=head1 PROVIDED METHODS

=over 4

=item B<count>

=item B<delete>

=item B<empty>

=item B<exists>

=item B<get>

=item B<keys>

=item B<add>

=item B<reset>

=item B<values>

=item B<kv>

=back

=cut
