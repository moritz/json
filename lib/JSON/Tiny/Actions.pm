unit class JSON::Tiny::Actions;

method TOP($/) {
    make $<value>.made;
};
method object($/) {
    make $<pairlist>.made.hash.item;
}

method pairlist($/) {
    make $<pair>>>.made.flat;
}

method pair($/) {
    make $<string>.made => $<value>.made;
}

method array($/) {
    make $<arraylist>.made.item;
}

method arraylist($/) {
    make [$<value>.map(*.made)];
}

method string($/) {
    my $str =  +@$<str> == 1
        ?? $<str>[0].made
        !! $<str>>>.made.join;

    # see https://github.com/moritz/json/issues/25
    # when a combining character comes after an opening quote,
    # it doesn't become part of the quoted string, because
    # it's stuffed into the same grapheme as the quote.
    # so we need to extract those combining character(s)
    # from the match of the opening quote, and stuff it into the string.
    if $0.Str ne '"' {
        my @chars := $0.Str.NFC;
        $str = @chars[1..*].chrs ~ $str;
    }
    make $str
}
method value:sym<number>($/) { make +$/.Str }
method value:sym<string>($/) { make $<string>.made }
method value:sym<true>($/)   { make Bool::True  }
method value:sym<false>($/)  { make Bool::False }
method value:sym<null>($/)   { make Any }
method value:sym<object>($/) { make $<object>.made }
method value:sym<array>($/)  { make $<array>.made }

method str($/)               { make ~$/ }

my %h = '\\' => "\\",
        '/'  => "/",
        'b'  => "\b",
        'n'  => "\n",
        't'  => "\t",
        'f'  => "\f",
        'r'  => "\r",
        '"'  => "\"";
method str_escape($/) {
    if $<utf16_codepoint> {
        make utf16.new( $<utf16_codepoint>.map({:16(~$_)}) ).decode();
    } else {
        make %h{~$/};
    }
}


# vim: ft=perl6
