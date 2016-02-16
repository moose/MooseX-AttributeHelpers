package MooseX::AttributeHelpers::Trait::Collection::Array;
use Moose::Role;

our $VERSION = '0.25';

use MooseX::AttributeHelpers::MethodProvider::Array;

with 'MooseX::AttributeHelpers::Trait::Collection';

has 'method_provider' => (
    is        => 'ro',
    isa       => 'ClassName',
    predicate => 'has_method_provider',
    default   => 'MooseX::AttributeHelpers::MethodProvider::Array'
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
