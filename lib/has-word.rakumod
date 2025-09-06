# Naughty bits used in this module for performance
use nqp;

#- helper subs -----------------------------------------------------------------
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

#- has-word --------------------------------------------------------------------
# externally visible has-word function
my sub has-word(
  Str:D $haystack,
  Str:D $needle,
        :i(:$ignorecase),
        :m(:$ignoremark),
--> Bool:D) {
    $ignorecase
      ?? $ignoremark
        ?? wordicim($haystack, $needle)
        !! wordic(  $haystack, $needle)
      !! $ignoremark
        ?? wordim($haystack, $needle)
        !! word(  $haystack, $needle)
}

#- find-all-words --------------------------------------------------------------
# externally visible find-all-words function
my sub find-all-words(
  Str:D $haystack,
  Str:D $needle,
       :i(:$ignorecase),
       :m(:$ignoremark),
) {
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

#- all-words -------------------------------------------------------------------
# externally visible all-words function
my sub all-words(
  str $haystack,
  str $needle,
     :i(:$ignorecase),
     :m(:$ignoremark),
) {
    my &finder := $ignorecase
      ?? $ignoremark ?? &find-wordicim !! &find-wordic
      !! $ignoremark ?? &find-wordim   !! &find-word;
    my int $chars = nqp::chars($needle);
    my int $move  = $chars + 1;
    my int $pos;
    my $words := nqp::create(IterationBuffer);

    nqp::until(
      nqp::iseq_i(($pos = finder($haystack, $needle, $pos)),-1),
      nqp::stmts(
        nqp::push($words,nqp::substr($haystack,$pos,$chars)),
        $pos = nqp::add_i($pos,$move)
      )
    );

    $words.Slip
}

#- EXPORT ----------------------------------------------------------------------
my sub EXPORT(*@names) {
    my constant %valid =
      '&all-words'      => &all-words,
      '&find-all-words' => &find-all-words,
      '&has-word'       => &has-word,
    ;

    if @names {
        Map.new: @names.map: {
            if %valid{"&$_"} {
                %valid{"&$_"}:p
            }
            else {
                my ($in,$out) = .split(':', 2);
                if $out && %valid{"&$in"} -> &code {
                    Pair.new: "&$out", &code
                }
            }
        }
    }
    else {
        %valid
    }
}

# vim: expandtab shiftwidth=4
