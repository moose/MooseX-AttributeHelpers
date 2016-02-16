package MooseX::AttributeHelpers::Trait::Collection::List;
use Moose::Role;

our $VERSION = '0.26';

use MooseX::AttributeHelpers::MethodProvider::List;

with 'MooseX::AttributeHelpers::Trait::Collection';

has 'method_provider' => (
    is        => 'ro',
    isa       => 'ClassName',
    predicate => 'has_method_provider',
    default   => 'MooseX::AttributeHelpers::MethodProvider::List'
);

sub helper_type { 'ArrayRef' }

no Moose::Role;

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
