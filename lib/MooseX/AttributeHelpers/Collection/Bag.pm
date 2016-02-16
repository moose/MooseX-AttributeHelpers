package MooseX::AttributeHelpers::Collection::Bag;
use Moose;

our $VERSION = '0.26';

extends 'Moose::Meta::Attribute';
with 'MooseX::AttributeHelpers::Trait::Collection::Bag';

no Moose;

# register the alias ...
package # hide me from search.cpan.org
    Moose::Meta::Attribute::Custom::Collection::Bag;
sub register_implementation { 'MooseX::AttributeHelpers::Collection::Bag' }

1;

__END__

=pod

=head1 SYNOPSIS

  package Stuff;
  use Moose;
  use MooseX::AttributeHelpers;
  
  has 'word_histogram' => (
      metaclass => 'Collection::Bag',
      is        => 'ro',
      isa       => 'Bag', # optional ... as is default
      provides  => {
          'add'    => 'add_word',
          'get'    => 'get_count_for',            
          'empty'  => 'has_any_words',
          'count'  => 'num_words',
          'delete' => 'delete_word',
      }
  );
  
=head1 DESCRIPTION

This module provides a Bag attribute which provides a number of 
bag-like operations. See L<MooseX::AttributeHelpers::MethodProvider::Bag>
for more details.

=head1 METHODS

=over 4

=item B<meta>

=item B<method_provider>

=item B<has_method_provider>

=item B<helper_type>

=item B<process_options_for_provides>

=back

=cut
