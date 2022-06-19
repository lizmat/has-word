[![Actions Status](https://github.com/lizmat/has-word/workflows/test/badge.svg)](https://github.com/lizmat/has-word/actions)

NAME
====

has-word - A quick non-regex word-boundary checker

SYNOPSIS
========

```raku
use has-word;

say has-word("foobarbaz", "foo");                   # False
say has-word("foo barbaz", "foo");                  # True
say has-word("foo::bar::baz", "bar");               # True
say has-word("foo::bar::baz", "BAZ", :ignorecase);  # True
say has-word("foo::bar::báz", "baz", :ignoremark);  # True

.say for find-all-words("foo bar foo", "foo");      # 0␤8␤
```

DESCRIPTION
===========

The `has-word` module exports a two subroutines that provide a quick way to see whether a string occurs as a "word" (defined as a number of alphanumeric characters surrounded by either non-alphanumeric characters or the beginning or end of the string. As such, it provides the equivalent of the `word ` functionality in regular expressions, but much faster and with a simpler way of checking for words that cannot be determined at compile time.

SUBROUTINES
===========

has-word
--------

```raku
say has-word("foobarbaz", "foo");                   # False
say has-word("foo barbaz", "foo");                  # True
say has-word("foo::bar::baz", "bar");               # True
say has-word("foo::bar::baz", "BAZ", :ignorecase);  # True
```

The `has-word` subroutine takes the haystack string as the first positional argument, and the needle string as the second positional argument. It also optionally takes an `:ignorecase` (or `:i`) named argument to perform the search in a case-insensitive manner, and/or an `:ignoremark` (or `:m`) named argument to perform the search by only comparing the base characters.

It returns either `True` if found, or `False` if not.

find-all-words
--------------

```raku
.say for find-all-words("foo bar foo", "foo");      # 0␤8␤
```

The `find-all-words` subroutine takes the haystack string as the first positional argument, and the needle string as the second positional argument. It also optionally takes an `:ignorecase` (or `:i`) named argument to perform the search in a case-insensitive manner, and/or an `:ignoremark` (or `:m`) named argument to perform the search by only comparing base characters. It returns a `List` of positions in the haystack string where the needle string was found.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

COPYRIGHT AND LICENSE
=====================

Copyright 2021, 2022 Elizabeth Mattijsen

Source can be located at: https://github.com/lizmat/has-word . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

