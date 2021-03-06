package MooseX::AttributeHelpers::MethodProvider::Counter;
use Moose::Role;

our $VERSION = '0.26';

sub reset : method {
    my ($attr, $reader, $writer) = @_;
    return sub { $writer->($_[0], $attr->default($_[0])) };
}

sub set : method {
    my ($attr, $reader, $writer, $value) = @_;
    return sub { $writer->($_[0], $_[1]) };
}

sub inc {
    my ($attr, $reader, $writer) = @_;
    return sub { $writer->($_[0], $reader->($_[0]) + (defined($_[1]) ? $_[1] : 1) ) };
}

sub dec {
    my ($attr, $reader, $writer) = @_;
    return sub { $writer->($_[0], $reader->($_[0]) - (defined($_[1]) ? $_[1] : 1) ) };
}

1;

__END__

=pod

=head1 DESCRIPTION

This is a role which provides the method generators for 
L<MooseX::AttributeHelpers::Counter>.

=head1 METHODS

=over 4

=item B<meta>

=back

=head1 PROVIDED METHODS

=over 4

=item B<set>

=item B<inc>

=item B<dec>

=item B<reset>

=back

=cut
