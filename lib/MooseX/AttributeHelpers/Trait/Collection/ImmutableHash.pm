package MooseX::AttributeHelpers::Trait::Collection::ImmutableHash;
use Moose::Role;

our $VERSION = '0.25';

use MooseX::AttributeHelpers::MethodProvider::ImmutableHash;

with 'MooseX::AttributeHelpers::Trait::Collection';

has 'method_provider' => (
    is        => 'ro',
    isa       => 'ClassName',
    predicate => 'has_method_provider',
    default   => 'MooseX::AttributeHelpers::MethodProvider::ImmutableHash'
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
