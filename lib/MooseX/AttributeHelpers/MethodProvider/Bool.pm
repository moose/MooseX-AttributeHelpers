package MooseX::AttributeHelpers::MethodProvider::Bool;
use Moose::Role;

our $VERSION = '0.25';

sub set : method {
    my ($attr, $reader, $writer) = @_;
    return sub { $writer->($_[0], 1) };
}

sub unset : method {
    my ($attr, $reader, $writer) = @_;
    return sub { $writer->($_[0], 0) };
}

sub toggle : method {
    my ($attr, $reader, $writer) = @_;
    return sub { $writer->($_[0], !$reader->($_[0])) };
}

sub not : method {
    my ($attr, $reader, $writer) = @_;
    return sub { !$reader->($_[0]) };
}

1;

__END__

=pod

=head1 DESCRIPTION

This is a role which provides the method generators for 
L<MooseX::AttributeHelpers::Bool>.

=head1 METHODS

=over 4

=item B<meta>

=back

=head1 PROVIDED METHODS

=over 4

=item B<set>

=item B<unset>

=item B<toggle>

=item B<not>

=back

=head1 AUTHOR

Jason May E<lt>jason.a.may@gmail.comE<gt>

=cut
