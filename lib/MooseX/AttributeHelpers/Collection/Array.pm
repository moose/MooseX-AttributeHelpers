package MooseX::AttributeHelpers::Collection::Array;
use Moose;

our $VERSION = '0.26';

extends 'Moose::Meta::Attribute';
with 'MooseX::AttributeHelpers::Trait::Collection::Array';

no Moose;

# register the alias ...
package # hide me from search.cpan.org
    Moose::Meta::Attribute::Custom::Collection::Array;
sub register_implementation { 'MooseX::AttributeHelpers::Collection::Array' }


1;

__END__

=pod

=head1 SYNOPSIS

  package Stuff;
  use Moose;
  use MooseX::AttributeHelpers;
  
  has 'options' => (
      metaclass => 'Collection::Array',
      is        => 'ro',
      isa       => 'ArrayRef[Int]',
      default   => sub { [] },
      provides  => {
          'push' => 'add_options',
          'pop'  => 'remove_last_option',
      }
  );

=head1 DESCRIPTION

This module provides an Array attribute which provides a number of 
array operations. See L<MooseX::AttributeHelpers::MethodProvider::Array>
for more details.

=head1 METHODS

=over 4

=item B<meta>

=item B<method_provider>

=item B<has_method_provider>

=item B<helper_type>

=back

=cut
