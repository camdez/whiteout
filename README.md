Whiteout
========

[![Build Status](https://secure.travis-ci.org/camdez/whiteout.png?branch=master)](http://travis-ci.org/camdez/whiteout)

Remove annoying trailing whitespace from files.

**Warning:** this is alpha-quality code written with the assistance of
  several glasses of gin. It's entirely possibly that it may eat your
  files, your children, or your future, and I disclaim responsibility
  for any of that.

Installation
------------

RubyGems:

```bash
$ gem install whiteout
$ whiteout -h
```

Use
---

```bash
$ echo -e "foo  \nbar" | whiteout
foo
bar
$ whiteout file1.rb file2.rb # modified in place
```

Issues
------

<http://github.com/camdez/whiteout/issues>
