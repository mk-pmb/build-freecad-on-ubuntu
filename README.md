
<!--#echo json="package.json" key="name" underline="=" -->
build-freecad-on-ubuntu
=======================
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
Automate some parts of FreeCAD's build process on Ubuntu.
<!--/#echo -->

[FreeCAD][fcrepo] is quite a neat CAD program,
but had some severe UX problem when I discovered it.
So I tried to fix them, and found a meta-UX problem:
Fixing FreeCAD requires compiling it, and that was way more cumbersome
than it should have been, so let's fix that meta-UX problem first.

This project started as [PR 508][fcpr-508] because at the time I didn't
think about where it should live. After @kkremitzki pointed it out, it was
easy to see that it's actually independent enough to live in its own repo.


So how do I compile FreeCAD?
----------------------------

* <del>Clone this repo</del>
* Go to the [Compile on Unix wiki page](https://www.freecadweb.org/wiki/CompileOnUnix) ([Wayback Backup](http://web.archive.org/web/20161208014052/http://www.freecadweb.org/wiki/?title=CompileOnUnix))
* Ignore the laborious instructions.
* Scroll straight down to the bottom and read the
  [chapter "Automatic build scripts"](https://www.freecadweb.org/wiki/CompileOnUnix#Automatic_build_scripts) ([Wayback Backup](http://web.archive.org/web/20161208014052/http://www.freecadweb.org/wiki/?title=CompileOnUnix#Automatic_build_scripts)).











<!--#toc stop="scan" -->


Get a list of dependency packages
---------------------------------

```bash
$ LANG=C apt-get build-dep --simulate freecad | grep -Pe '^\d+ ' -m 1 -B 9002
```

If that one fails you, you can still use the approach I invented before
I had discovered the hidden chapter:

```bash
$ cd install-deps/
$ ./install_deps.sh
Downloading how-to from wiki: tmp.2017-02-11.howto.html (skip: you already have it.)
Extract list of dependencies:
Found 38 package names and 1 other messages:
     1  Additional instruction: for libcoin80-dev Debian
        wheezy-backports, unstable, testing, <want=yes>Ubuntu 13.10 and forward
        /web/20161208014052/http://forum.freecadweb.org/viewtopic.php?f=4&t=5096#p40018
You'll have to resolve these issues manually. :-( When you did, you can run: sudo apt-get install $(cat dep-pkgs.lst)
```





Known issues
------------

* Obsolete.





&nbsp;

  [fcrepo]: https://github.com/FreeCAD/FreeCAD
  [fcpr-508]: https://github.com/FreeCAD/FreeCAD/pull/508

License
-------
<!--#echo json="package.json" key=".license" -->
ISC
<!--/#echo -->
