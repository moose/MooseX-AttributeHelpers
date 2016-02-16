package MooseX::AttributeHelpers::Collection::ImmutableHash;
use Moose;

our $VERSION = '0.26';

extends 'Moose::Meta::Attribute';
with 'MooseX::AttributeHelpers::Trait::Collection::ImmutableHash';

no Moose;

# register the alias ...
package # hide me from search.cpan.org
    Moose::Meta::Attribute::Custom::Collection::ImmutableHash;
sub register_implementation { 'MooseX::AttributeHelpers::Collection::ImmutableHash' }


1;

__END__

=pod

=head1 SYNOPSIS

  package Stuff;
  use Moose;
  use MooseX::AttributeHelpers;
  
  has 'options' => (
      metaclass => 'Collection::ImmutableHash',
      is        => 'ro',
      isa       => 'HashRef[Str]',
      default   => sub { {} },
      provides  => {
          'get'    => 'get_option',            
          'empty'  => 'has_options',
          'keys'   => 'get_option_list',
      }
  );
  
=head1 DESCRIPTION

This module provides a immutable HashRef attribute which provides a number of 
hash-line operations. See L<MooseX::AttributeHelpers::MethodProvider::ImmutableHash>
for more details.

=head1 METHODS

=over 4

=item B<meta>

=item B<method_provider>

=item B<has_method_provider>

=item B<helper_type>

=back

=cut
