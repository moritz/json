use v6;
use Test;
use JSON::Tiny;
plan 2;

class Something { 
   has Str $.foo;
   has Str $.bar;

   method TO_JSON {
      return {
          foo => $.foo
      }
   }
}

my %something = from-json( to-json Something.new( foo => 'Interested', bar => 'Not interested' ) );

is( %something<foo>, 'Interested', 'Include property' );
isnt( %something<bar>, 'Not interested', 'Exclude property');