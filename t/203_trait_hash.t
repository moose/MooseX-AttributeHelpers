#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 35;
use Test::Exception;
use Test::Moose 'does_ok';

BEGIN {
    use_ok('MooseX::AttributeHelpers');   
}

{
    package Stuff;
    use Moose;
    use MooseX::AttributeHelpers;

    has 'options' => (
        traits    => [qw/MooseX::AttributeHelpers::Trait::Collection::Hash/],
        is        => 'ro',
        isa       => 'HashRef[Str]',
        default   => sub { {} },
        provides  => {
            'set'    => 'set_option',
            'get'    => 'get_option',            
            'empty'  => 'has_options',
            'count'  => 'num_options',
            'clear'  => 'clear_options',
            'delete' => 'delete_option',
        }
    );
}

my $stuff = Stuff->new();
isa_ok($stuff, 'Stuff');

can_ok($stuff, $_) for qw[
    set_option
    get_option
    has_options
    num_options
    delete_option
    clear_options
];

ok(!$stuff->has_options, '... we have no options');
is($stuff->num_options, 0, '... we have no options');

is_deeply($stuff->options, {}, '... no options yet');

lives_ok {
    $stuff->set_option(foo => 'bar');
} '... set the option okay';

ok($stuff->has_options, '... we have options');
is($stuff->num_options, 1, '... we have 1 option(s)');
is_deeply($stuff->options, { foo => 'bar' }, '... got options now');

lives_ok {
    $stuff->set_option(bar => 'baz');
} '... set the option okay';

is($stuff->num_options, 2, '... we have 2 option(s)');
is_deeply($stuff->options, { foo => 'bar', bar => 'baz' }, '... got more options now');

is($stuff->get_option('foo'), 'bar', '... got the right option');

is_deeply([ $stuff->get_option(qw(foo bar)) ], [qw(bar baz)], "get multiple options at once");

lives_ok {
    $stuff->set_option(oink => "blah", xxy => "flop");
} '... set the option okay';

is($stuff->num_options, 4, "4 options");
is_deeply([ $stuff->get_option(qw(foo bar oink xxy)) ], [qw(bar baz blah flop)], "get multiple options at once");

lives_ok {
    $stuff->delete_option('bar');
} '... deleted the option okay';

lives_ok {
    $stuff->delete_option('oink');
} '... deleted the option okay';

lives_ok {
    $stuff->delete_option('xxy');
} '... deleted the option okay';

is($stuff->num_options, 1, '... we have 1 option(s)');
is_deeply($stuff->options, { foo => 'bar' }, '... got more options now');

$stuff->clear_options;

is_deeply($stuff->options, { }, "... cleared options" );

lives_ok {
    Stuff->new(options => { foo => 'BAR' });
} '... good constructor params';

## check some errors

dies_ok {
    $stuff->set_option(bar => {});
} '... could not add a hash ref where an string is expected';

dies_ok {
    Stuff->new(options => { foo => [] });
} '... bad constructor params';

## test the meta

my $options = $stuff->meta->get_attribute('options');
does_ok($options, 'MooseX::AttributeHelpers::Trait::Collection::Hash');

is_deeply($options->provides, {
    'set'    => 'set_option',
    'get'    => 'get_option',            
    'empty'  => 'has_options',
    'count'  => 'num_options',
    'clear'  => 'clear_options',
    'delete' => 'delete_option',
}, '... got the right provies mapping');

is($options->type_constraint->type_parameter, 'Str', '... got the right container type');
