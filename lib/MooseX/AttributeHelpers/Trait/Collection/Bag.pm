package MooseX::AttributeHelpers::Trait::Collection::Bag;
use Moose::Role;
use Moose::Util::TypeConstraints;

our $VERSION = '0.26';

use MooseX::AttributeHelpers::MethodProvider::Bag;

with 'MooseX::AttributeHelpers::Trait::Collection';

has 'method_provider' => (
    is        => 'ro',
    isa       => 'ClassName',
    predicate => 'has_method_provider',
    default   => 'MooseX::AttributeHelpers::MethodProvider::Bag'
);

subtype 'Bag' => as 'HashRef[Int]';

sub helper_type { 'Bag' }

before 'process_options_for_provides' => sub {
    my ($self, $options, $name) = @_;

    # Set some default attribute options here unless already defined
    if ((my $type = $self->helper_type) && !exists $options->{isa}){
        $options->{isa} = $type;
    }
    
    $options->{default} = sub { +{} } unless exists $options->{default};
};

no Moose::Role;
no Moose::Util::TypeConstraints;

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
      isa       => 'Bag', # optional ... as is defalt
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
