package MooseX::AttributeHelpers::Trait::Collection;
# ABSTRACT: Base class for all collection type helpers
use Moose::Role;

our $VERSION = '0.25';

with 'MooseX::AttributeHelpers::Trait::Base';

no Moose::Role;

1;

__END__

=pod

=head1 DESCRIPTION

Documentation to come.

=head1 METHODS

=over 4

=item B<meta>

=item B<container_type>

=item B<container_type_constraint>

=item B<has_container_type>

=item B<process_options_for_provides>

=back

=cut
