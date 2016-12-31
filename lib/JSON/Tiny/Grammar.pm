use v6;
unit grammar JSON::Tiny::Grammar;

token TOP       { \s* <value> \s* }
rule object     { '{' ~ '}' <pairlist>     }
rule pairlist   { <pair> * % \,            }
rule pair       { <string> ':' <value>     }
rule array      { '[' ~ ']' <arraylist>    }
rule arraylist  {  <value> * % [ \, ]        }

proto token value {*};
token value:sym<number> {
    '-'?
    [ 0 | <[1..9]> <[0..9]>* ]
    [ \. <[0..9]>+ ]?
    [ <[eE]> [\+|\-]? <[0..9]>+ ]?
}
token value:sym<true>    { <sym>    };
token value:sym<false>   { <sym>    };
token value:sym<null>    { <sym>    };
token value:sym<object>  { <object> };
token value:sym<array>   { <array>  };
token value:sym<string>  { <string> }

token string {
    # see https://github.com/moritz/json/issues/25
    (:ignoremark '"') ~ \" [ <str> | \\ <str=.str_escape> ]*
}

token str {
    <-["\\\t\x[0A]]>+
}

token str_escape {
    <["\\/bfnrt]> | 'u' <utf16_codepoint>+ % '\u'
}

token utf16_codepoint {
    <.xdigit>**4
}

# vim: ft=perl6
