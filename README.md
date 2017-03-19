# Example

A simple Perl 6 module for serializing and deserializing JSON.

    use JSON::Tiny;
    say from-json('{ "a": 42 }').perl;
    say to-json { a => [1, 2, 'b'] };

# Supported Standards

JSON::Tiny implements RFC7159, which is a superset of ECMA-404, in that it
permits any value as a top-level JSON string, not just arrays and objects.

# License

All files (unless noted otherwise) can be used, modified and redistributed
under the terms of the Artistic License Version 2. Examples (in the
documentation, in tests or distributed as separate files) can be considered
public domain.

# Installation and Tests

To install this module, please use zef from https://github.com/ugexe/zef and
type

    zef install JSON::Tiny

or from a checkout of this source treeor from a checkout of this source tree,

    zef install .

You can run the test suite locally like this:

    prove -e 'perl6 -Ilib' t/
