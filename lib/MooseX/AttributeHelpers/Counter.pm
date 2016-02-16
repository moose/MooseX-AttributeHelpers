package MooseX::AttributeHelpers::Counter;
use Moose;

our $VERSION = '0.26';

extends 'Moose::Meta::Attribute';
with 'MooseX::AttributeHelpers::Trait::Counter';

no Moose;

# register the alias ...
package # hide me from search.cpan.org
    Moose::Meta::Attribute::Custom::Counter;
sub register_implementation { 'MooseX::AttributeHelpers::Counter' }

1;

__END__

=pod

=head1 METHODS

=over 4

=item B<meta>

=item B<method_provider>

=item B<has_method_provider>

=item B<helper_type>

=item B<process_options_for_provides>

Run before its superclass method.

=item B<check_provides_values>

Run after its superclass method.

=back

=cut
