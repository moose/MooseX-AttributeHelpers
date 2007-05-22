#!/usr/bin/perl

use strict;
use warnings;

use Test::More no_plan => 1;
use Test::Exception;

BEGIN {
    use_ok('MooseX::AttributeHelpers');   
}

{
    package Stuff;
    use Moose;

    has 'options' => (
        metaclass => 'Collection::Array',
        is        => 'ro',
        isa       => 'ArrayRef[Int]',
        default   => sub { [] },
        provides  => {
            'push'    => 'add_options',
            'pop'     => 'remove_last_option',    
            'shift'   => 'remove_first_option',
            'unshift' => 'insert_options',
            'get'     => 'get_option_at',
            'set'     => 'set_option_at',
            'count'   => 'num_options',
            'empty'   => 'has_options',        
        }
    );
}

my $stuff = Stuff->new();
isa_ok($stuff, 'Stuff');

can_ok($stuff, $_) for qw[
    add_options
    remove_last_option
    remove_first_option
    insert_options
    get_option_at
    set_option_at
    num_options
    has_options
];

is_deeply($stuff->options, [], '... no options yet');

ok(!$stuff->has_options, '... no options');
is($stuff->num_options, 0, '... got no options');

lives_ok {
    $stuff->add_options(1, 2, 3);
} '... set the option okay';

is_deeply($stuff->options, [1, 2, 3], '... got options now');

ok($stuff->has_options, '... no options');
is($stuff->num_options, 3, '... got 3 options');

is($stuff->get_option_at(0), 1, '... get option at index 0');
is($stuff->get_option_at(1), 2, '... get option at index 1');
is($stuff->get_option_at(2), 3, '... get option at index 2');

lives_ok {
    $stuff->set_option_at(1, 100);
} '... set the option okay';

is($stuff->get_option_at(1), 100, '... get option at index 1');

lives_ok {
    $stuff->add_options(10, 15);
} '... set the option okay';

is_deeply($stuff->options, [1, 100, 3, 10, 15], '... got more options now');

is($stuff->num_options, 5, '... got 5 options');

is($stuff->remove_last_option, 15, '... removed the last option');

is($stuff->num_options, 4, '... got 4 options');
is_deeply($stuff->options, [1, 100, 3, 10], '... got diff options now');

lives_ok {
    $stuff->insert_options(10, 20);
} '... set the option okay';

is($stuff->num_options, 6, '... got 6 options');
is_deeply($stuff->options, [10, 20, 1, 100, 3, 10], '... got diff options now');

is($stuff->get_option_at(0), 10, '... get option at index 0');
is($stuff->get_option_at(1), 20, '... get option at index 1');
is($stuff->get_option_at(3), 100, '... get option at index 3');

is($stuff->remove_first_option, 10, '... getting the first option');

is($stuff->num_options, 5, '... got 5 options');
is($stuff->get_option_at(0), 20, '... get option at index 0');

## check some errors

dies_ok {
    $stuff->add_options([]);
} '... could not add an array ref where an int is expected';

dies_ok {
    $stuff->insert_options(undef);
} '... could not add an undef where an int is expected';

dies_ok {
    $stuff->set_option(5, {});
} '... could not add a hash ref where an int is expected';

## test the meta

my $options = $stuff->meta->get_attribute('options');
isa_ok($options, 'MooseX::AttributeHelpers::Collection::Array');

is_deeply($options->provides, {
    'push'    => 'add_options',
    'pop'     => 'remove_last_option',    
    'shift'   => 'remove_first_option',
    'unshift' => 'insert_options',
    'get'     => 'get_option_at',
    'set'     => 'set_option_at',
    'count'   => 'num_options',
    'empty'   => 'has_options',    
}, '... got the right provies mapping');

is($options->container_type, 'Int', '... got the right container type');