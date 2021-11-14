# Naughty bits used in this module for performance
use nqp;

my sub has-word(Str:D $haystack, Str:D $needle, :$ignorecase) is export {
    $ignorecase
      ?? has-wordic($haystack, $needle)
      !! has-wordc( $haystack, $needle)
}

# Fast non-regex checker whether a string has word-boundaries
my sub has-wordc(str $h, str $n) {
    my int $pos;
    my int $hc = nqp::chars($h);  # chars in haystack
    my int $nc = nqp::chars($n);  # chars in needle

    nqp::until(
      nqp::iseq_i(($pos = nqp::index($h,$n,$pos)),-1)  # not found
        || (
             (nqp::iseq_i($pos,0)  # borders at start
               || nqp::isne_i(     # different class of chars at boundary
                    nqp::iscclass(
                      nqp::const::CCLASS_WORD,
                      $h,
                      $pos
                    ),
                    nqp::iscclass(
                      nqp::const::CCLASS_WORD,
                      $h,
                      nqp::sub_i($pos,1)
                    )
                  )
             )
          && (nqp::iseq_i(nqp::add_i($pos,$nc),$hc)  # borders at end
               || nqp::isne_i(     # different class of chars at boundary
                    nqp::iscclass(
                      nqp::const::CCLASS_WORD,
                      $h,
                      nqp::add_i($pos,$nc)
                    ),
                    nqp::iscclass(
                      nqp::const::CCLASS_WORD,
                      $h,
                      nqp::sub_i(nqp::add_i($pos,$nc),1)
                    )
                  )

             )
           ),
      ($pos = nqp::add_i($pos,$nc))                 # try again
    );

    nqp::hllbool(nqp::isne_i($pos,-1))
}

# case insensitive version, otherwise identical to "has-wordc"
my sub has-wordic(str $h, str $n) {
    my int $pos;
    my int $hc = nqp::chars($h);  # chars in haystack
    my int $nc = nqp::chars($n);  # chars in needle

    nqp::until(
      nqp::iseq_i(($pos = nqp::indexic($h,$n,$pos)),-1)  # not found
        || (
             (nqp::iseq_i($pos,0)  # borders at start
               || nqp::isne_i(     # different class of chars at boundary
                    nqp::iscclass(
                      nqp::const::CCLASS_WORD,
                      $h,
                      $pos
                    ),
                    nqp::iscclass(
                      nqp::const::CCLASS_WORD,
                      $h,
                      nqp::sub_i($pos,1)
                    )
                  )
             )
          && (nqp::iseq_i(nqp::add_i($pos,$nc),$hc)  # borders at end
               || nqp::isne_i(     # different class of chars at boundary
                    nqp::iscclass(
                      nqp::const::CCLASS_WORD,
                      $h,
                      nqp::add_i($pos,$nc)
                    ),
                    nqp::iscclass(
                      nqp::const::CCLASS_WORD,
                      $h,
                      nqp::sub_i(nqp::add_i($pos,$nc),1)
                    )
                  )

             )
           ),
      ($pos = nqp::add_i($pos,$nc))                 # try again
    );

    nqp::hllbool(nqp::isne_i($pos,-1))
}

=begin pod

=head1 NAME

has-word - A quick non-regex word-boundary checker

=head1 SYNOPSIS

=begin code :lang<raku>

use has-word;

say has-word("foobarbaz", "foo");      # False
say has-word("foo barbaz", "foo");     # True
say has-word("foo::bar::baz", "bar");  # True
say has-word("foo::bar::baz", "baz");  # True

=end code

=head1 DESCRIPTION

The C<has-word> module exports a single subroutine C<has-word> that provides
a quick way to see whether a string occurs as a "word" (defined as a number of
alphanumeric characters surrounded by either non-alphanumeric characters or
the beginning or end of the string.  As such, it provides the equivalent of
the C<<< word >>> functionality in regular expressions, but much faster and
with a simpler way of checking for words that cannot be determined at compile
time.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

=head1 COPYRIGHT AND LICENSE

Copyright 2021 Elizabeth Mattijsen

Source can be located at: https://github.com/lizmat/has-word .
Comments and Pull Requests are welcome.

This library is free software; you can redistribute it and/or modify it
under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
