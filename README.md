NAME
====

has-word - A quick non-regex word-boundary checker

SYNOPSIS
========

```raku
use has-word;

say has-word("foobarbaz", "foo");      # False
say has-word("foo barbaz", "foo");     # True
say has-word("foo::bar::baz", "bar");  # True
say has-word("foo::bar::baz", "baz");  # True
```

DESCRIPTION
===========

The `has-word` module exports a single subroutine `has-word` that provides a quick way to see whether a string occurs as a "word" (defined as a number of alphanumeric characters surrounded by either non-alphanumeric characters or the beginning or end of the string. As such, it provides the equivalent of the `word ` functionality in regular expressions, but much faster and with a simpler way of checking for words that cannot be determined at compile time.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

COPYRIGHT AND LICENSE
=====================

Copyright 2021 Elizabeth Mattijsen

Source can be located at: https://github.com/lizmat/has-word . Comments and Pull Requests are welcome.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

