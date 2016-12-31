use v6;
use JSON::Tiny;
use Test;

my @t =
    '{ "a" : "b\u00E5" }' => { 'a' => 'bå' },
    '[ "\u2685" ]' => [ '⚅' ],
    # issue #25
    qq{"x\c[ZERO WIDTH JOINER]a"} => "x\c[ZERO WIDTH JOINER]a",
    qq{"\c[ZERO WIDTH JOINER]"} => "\c[ZERO WIDTH JOINER]",
    ;

plan (+@t);
for @t -> $p {
    my $got = from-json($p.key);
    is-deeply $got, $p.value, "Correct data structure for «{$p.key}»"
        or say "# Got: $got.perl()\n# Expected: {$p.value.perl}";
}
