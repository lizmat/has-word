# Naughty bits used in this module for performance
use nqp;

# Fast non-regex checker where a string has word-boundaries
my sub find-word(str $h, str $n, int $initial --> int) {
    my int $pos = $initial;
    my int $hc  = nqp::chars($h);  # chars in haystack
    my int $nc  = nqp::chars($n);  # chars in needle

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
    $pos
}

# case insensitive version, otherwise identical to "find-word"
my sub find-wordic(str $h, str $n, int $initial --> int) {
    my int $pos = $initial;
    my int $hc  = nqp::chars($h);  # chars in haystack
    my int $nc  = nqp::chars($n);  # chars in needle

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
    $pos
}

# mark insensitive version, otherwise identical to "find-wordc
my sub find-wordim(str $h, str $n, int $initial --> int) {
    my int $pos = $initial;
    my int $hc  = nqp::chars($h);  # chars in haystack
    my int $nc  = nqp::chars($n);  # chars in needle

    nqp::until(
      nqp::iseq_i(($pos = nqp::indexim($h,$n,$pos)),-1)  # not found
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
    $pos
}

# case and mark insensitive version, otherwise identical to "find-word"
my sub find-wordicim(str $h, str $n, int $initial --> int) {
    my int $pos = $initial;
    my int $hc  = nqp::chars($h);  # chars in haystack
    my int $nc  = nqp::chars($n);  # chars in needle

    nqp::until(
      nqp::iseq_i(($pos = nqp::indexicim($h,$n,$pos)),-1)  # not found
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
    $pos
}

# externally visible has-word function
my sub has-word(
  Str:D $haystack,
  Str:D $needle,
        :i(:$ignorecase),
        :m(:$ignoremark),
--> Bool:D) is export {
    $ignorecase
      ?? $ignoremark
        ?? wordicim($haystack, $needle)
        !! wordic(  $haystack, $needle)
      !! $ignoremark
        ?? wordim($haystack, $needle)
        !! word(  $haystack, $needle)
}

# Fast non-regex checker whether a string has word-boundaries
my sub word(str $h, str $n --> Bool:D) {
    nqp::hllbool(nqp::isne_i(find-word($h, $n, 0),-1))
}

# case insensitive version, otherwise identical to "has-word"
my sub wordic(str $h, str $n --> Bool:D) {
    nqp::hllbool(nqp::isne_i(find-wordic($h, $n, 0),-1))
}

# mark insensitive version, otherwise identical to "has-word"
my sub wordim(str $h, str $n --> Bool:D) {
    nqp::hllbool(nqp::isne_i(find-wordim($h, $n, 0),-1))
}

# case and mark insensitive version, otherwise identical to "has-word"
my sub wordicim(str $h, str $n --> Bool:D) {
    nqp::hllbool(nqp::isne_i(find-wordicim($h, $n, 0),-1))
}

# externally visible find-all-words function
my sub find-all-words(
  Str:D $haystack,
  Str:D $needle,
        :i(:$ignorecase),
        :m(:$ignoremark),
) is export {
    my &finder := $ignorecase
      ?? $ignoremark ?? &find-wordicim !! &find-wordic
      !! $ignoremark ?? &find-wordim   !! &find-word;
    my int $move = nqp::chars($needle) + 1;
    my int $pos;
    my int @positions;

    nqp::until(
      nqp::iseq_i(($pos = finder($haystack, $needle, $pos)),-1),
      $pos = nqp::add_i(nqp::push_i(@positions,$pos),$move)
    );

    @positions
}

=begin pod

=head1 NAME

has-word - A quick non-regex word-boundary checker

=head1 SYNOPSIS

=begin code :lang<raku>

use has-word;

say has-word("foobarbaz", "foo");                   # False
say has-word("foo barbaz", "foo");                  # True
say has-word("foo::bar::baz", "bar");               # True
say has-word("foo::bar::baz", "BAZ", :ignorecase);  # True
say has-word("foo::bar::báz", "baz", :ignoremark);  # True

.say for find-all-words("foo bar foo", "foo");      # 0␤8␤

=end code

=head1 DESCRIPTION

The C<has-word> module exports a two subroutines that provide
a quick way to see whether a string occurs as a "word" (defined as a number of
alphanumeric characters surrounded by either non-alphanumeric characters or
the beginning or end of the string.  As such, it provides the equivalent of
the C<<< word >>> functionality in regular expressions, but much faster and
with a simpler way of checking for words that cannot be determined at compile
time.

=head1 SUBROUTINES

=head2 has-word

=begin code :lang<raku>

say has-word("foobarbaz", "foo");                   # False
say has-word("foo barbaz", "foo");                  # True
say has-word("foo::bar::baz", "bar");               # True
say has-word("foo::bar::baz", "BAZ", :ignorecase);  # True

=end code

The C<has-word> subroutine takes the haystack string as the first positional
argument, and the needle string as the second positional argument.  It also
optionally takes an C<:ignorecase> (or C<:i>) named argument to perform the
search in a case-insensitive manner, and/or an C<:ignoremark> (or C<:m>) named
argument to perform the search by only comparing the base characters.

It returns either C<True> if found, or C<False> if not.

=head2 find-all-words

=begin code :lang<raku>

.say for find-all-words("foo bar foo", "foo");      # 0␤8␤

=end code

The C<find-all-words> subroutine takes the haystack string as the first
positional argument, and the needle string as the second positional
argument.  It also optionally takes an C<:ignorecase> (or C<:i>) named
argument to perform the search in a case-insensitive manner, and/or an
C<:ignoremark> (or C<:m>) named argument to perform the search by only
comparing base characters.  It returns a C<List> of positions in the
haystack string where the needle string was found.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

=head1 COPYRIGHT AND LICENSE

Copyright 2021, 2022 Elizabeth Mattijsen

Source can be located at: https://github.com/lizmat/has-word .
Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

This library is free software; you can redistribute it and/or modify it
under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
