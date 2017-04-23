use v6;
use Test;

use JSON::Tiny;

my $contents = slurp 'META6.json';
ok $contents, 'can read META6.json';
my %decoded;
lives-ok {
    %decoded = from-json($contents);
}, 'can decode META6.json';

ok %decoded, 'META6.json is not empty';
for <perl name description license provides source-url> -> $key {
    ok %decoded{$key}.defined, "key $key present";
}

done-testing;
