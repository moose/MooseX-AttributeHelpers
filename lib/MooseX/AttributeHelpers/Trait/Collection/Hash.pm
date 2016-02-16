package MooseX::AttributeHelpers::Trait::Collection::Hash;
use Moose::Role;

our $VERSION = '0.25';

use MooseX::AttributeHelpers::MethodProvider::Hash;

with 'MooseX::AttributeHelpers::Trait::Collection';

has 'method_provider' => (
    is        => 'ro',
    isa       => 'ClassName',
    predicate => 'has_method_provider',
    default   => 'MooseX::AttributeHelpers::MethodProvider::Hash'
);

sub helper_type { 'HashRef' }

no Moose::Role;

1;

__END__

=pod

=head1 SYNOPSIS

  package Stuff;
  use Moose;
  use MooseX::AttributeHelpers;

  has 'options' => (
      metaclass => 'Collection::Hash',
      is        => 'ro',
      isa       => 'HashRef[Str]',
      default   => sub { {} },
      provides  => {
          'set'    => 'set_option',
          'get'    => 'get_option',
          'empty'  => 'has_options',
          'count'  => 'num_options',
          'delete' => 'delete_option',
      }
  );

=head1 DESCRIPTION

This module provides a Hash attribute which provides a number of
hash-like operations. See L<MooseX::AttributeHelpers::MethodProvider::Hash>
for more details.

=head1 METHODS

=over 4

=item B<meta>

=item B<method_provider>

=item B<has_method_provider>

=item B<helper_type>

=back

=cut
