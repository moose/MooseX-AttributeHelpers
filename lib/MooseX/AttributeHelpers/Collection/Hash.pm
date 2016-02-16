package MooseX::AttributeHelpers::Collection::Hash;
use Moose;

our $VERSION = '0.26';

extends 'Moose::Meta::Attribute';
with 'MooseX::AttributeHelpers::Trait::Collection::Hash';

no Moose;

# register the alias ...
package # hide me from search.cpan.org
    Moose::Meta::Attribute::Custom::Collection::Hash;
sub register_implementation { 'MooseX::AttributeHelpers::Collection::Hash' }


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
