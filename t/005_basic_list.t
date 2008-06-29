#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Exception;

BEGIN {
    plan tests => 28;
}

BEGIN {
    use_ok('MooseX::AttributeHelpers');   
}

{
    package Stuff;
    use Moose;

    has '_options' => (
        metaclass => 'Collection::List',
        is        => 'ro',
        isa       => 'ArrayRef[Int]',
        init_arg  => 'options',
        default   => sub { [] },
        provides  => {
            'count'    => 'num_options',
            'empty'    => 'has_options',        
            'map'      => 'map_options',
            'grep'     => 'filter_options',
            'find'     => 'find_option',
            'elements' => 'options',
            'join'     => 'join_options',
            'get'      => 'get_option_at',
            'first'    => 'get_first_option',
            'last'     => 'get_last_option',
        },
        curries   => {
            'grep'     => {less_than_five => [ sub { $_ < 5 } ]},
            'map'      => {up_by_one      => [ sub { $_ + 1 } ]},
            'join'     => {dashify        => [ '-' ]}
        }
    );
}

my $stuff = Stuff->new(options => [ 1 .. 10 ]);
isa_ok($stuff, 'Stuff');

can_ok($stuff, $_) for qw[
    _options
    num_options
    has_options
    map_options
    filter_options
    find_option
    options
    join_options
    get_option_at
];

is_deeply($stuff->_options, [1 .. 10], '... got options');

ok($stuff->has_options, '... we have options');
is($stuff->num_options, 10, '... got 2 options');
cmp_ok($stuff->get_option_at(0), '==', 1, '... get option 0');
cmp_ok($stuff->get_first_option, '==', 1, '... get first');
cmp_ok($stuff->get_last_option, '==', 10, '... get first');

is_deeply(
[ $stuff->filter_options(sub { $_[0] % 2 == 0 }) ],
[ 2, 4, 6, 8, 10 ],
'... got the right filtered values'
);

is_deeply(
[ $stuff->map_options(sub { $_[0] * 2 }) ],
[ 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 ],
'... got the right mapped values'
);

is($stuff->find_option(sub { $_[0] % 2 == 0 }), 2, '.. found the right option');

is_deeply([ $stuff->options ], [1 .. 10], '... got the list of options');

is($stuff->join_options(':'), '1:2:3:4:5:6:7:8:9:10', '... joined the list of options by :');

# test the currying
is_deeply([ $stuff->less_than_five() ], [1 .. 4]);

is_deeply([ $stuff->up_by_one() ], [2 .. 11]);

is($stuff->dashify, '1-2-3-4-5-6-7-8-9-10');

## test the meta

my $options = $stuff->meta->get_attribute('_options');
isa_ok($options, 'MooseX::AttributeHelpers::Collection::List');

is_deeply($options->provides, {
    'map'      => 'map_options',
    'grep'     => 'filter_options',
    'find'     => 'find_option',
    'count'    => 'num_options',
    'empty'    => 'has_options',
    'elements' => 'options',
    'join'     => 'join_options',
    'get'      => 'get_option_at',
    'first'    => 'get_first_option',
    'last'     => 'get_last_option'
}, '... got the right provies mapping');

is($options->type_constraint->type_parameter, 'Int', '... got the right container type');
