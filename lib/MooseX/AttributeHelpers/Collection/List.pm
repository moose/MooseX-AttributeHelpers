package MooseX::AttributeHelpers::Collection::List;
use Moose;

our $VERSION = '0.25';

extends 'Moose::Meta::Attribute';
with 'MooseX::AttributeHelpers::Trait::Collection::List';

no Moose;

# register the alias ...
package # hide me from search.cpan.org
    Moose::Meta::Attribute::Custom::Collection::List;
sub register_implementation { 'MooseX::AttributeHelpers::Collection::List' }


1;

__END__

=pod

=head1 SYNOPSIS

  package Stuff;
  use Moose;
  use MooseX::AttributeHelpers;
  
  has 'options' => (
      metaclass => 'Collection::List',
      is        => 'ro',
      isa       => 'ArrayRef[Int]',
      default   => sub { [] },
      provides  => {
          map  => 'map_options',
          grep => 'filter_options',
      }
  );

=head1 DESCRIPTION

This module provides an List attribute which provides a number of 
list operations. See L<MooseX::AttributeHelpers::MethodProvider::List>
for more details.

=head1 METHODS

=over 4

=item B<meta>

=item B<method_provider>

=item B<has_method_provider>

=item B<helper_type>

=back

=cut
