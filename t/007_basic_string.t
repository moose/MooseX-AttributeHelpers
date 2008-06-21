#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 21;

BEGIN {
    use_ok('MooseX::AttributeHelpers');   
}

{
    package MyHomePage;
    use Moose;

    has 'string' => (
        metaclass => 'String',
        is        => 'rw',
        isa       => 'Str',
        default   => sub { '' },
        provides => {
            inc     => 'inc_string',
            append  => 'append_string',
            prepend => 'prepend_string',
            match   => 'match_string',
            replace => 'replace_string',
            chop    => 'chop_string',
            chomp   => 'chomp_string',
            clear   => 'clear_string',
        },
        curries  => {
            append  => {exclaim         => [ '!' ]},
            replace => {capitalize_last => [ qr/(.)$/, sub { uc $1 } ]},
            match   => {invalid_number  => [ qr/\D/ ]}
        }
    );
}

my $page = MyHomePage->new();
isa_ok($page, 'MyHomePage');

is($page->string, '', '... got the default value');

$page->string('a');

$page->inc_string; 
is($page->string, 'b', '... got the incremented value');

$page->inc_string; 
is($page->string, 'c', '... got the incremented value (again)');

$page->append_string("foo$/");
is($page->string, "cfoo$/", 'appended to string');

$page->chomp_string;
is($page->string, "cfoo", 'chomped string');

$page->chomp_string;
is($page->string, "cfoo", 'chomped is noop');

$page->chop_string;
is($page->string, "cfo", 'chopped string');

$page->prepend_string("bar");
is($page->string, 'barcfo', 'prepended to string');

is_deeply( [ $page->match_string(qr/([ao])/) ], [ "a" ], "match" );

$page->replace_string(qr/([ao])/, sub { uc($1) });
is($page->string, 'bArcfo', "substitution");

$page->exclaim;
is($page->string, 'bArcfo!', 'exclaim!');

$page->string('Moosex');
$page->capitalize_last;
is($page->string, 'MooseX', 'capitalize last');

$page->string('1234');
ok(!$page->invalid_number, 'string "isn\'t an invalid number');

$page->string('one two three four');
ok($page->invalid_number, 'string an invalid number');

$page->clear_string;
is($page->string, '', "clear");

# check the meta ..

my $string = $page->meta->get_attribute('string');
isa_ok($string, 'MooseX::AttributeHelpers::String');

is($string->helper_type, 'Str', '... got the expected helper type');

is($string->type_constraint->name, 'Str', '... got the expected type constraint');

is_deeply($string->provides, { 
    inc     => 'inc_string',
    append  => 'append_string',
    prepend => 'prepend_string',
    match   => 'match_string',
    replace => 'replace_string',
    chop    => 'chop_string',
    chomp   => 'chomp_string',
    clear   => 'clear_string',
}, '... got the right provides methods');

