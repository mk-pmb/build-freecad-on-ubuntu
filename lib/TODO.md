
TODO
====

Security
--------

* Research how to build without trusting the PPA.
* Research how to produce a verifiable build.


Install script
--------------

* Decide: Should each runmode be its own function?

* Support storing installer settings in `~/.config/FreeCAD/`
  * Copy an example config there if none found
  * Edition: stable|daily
  * BuildType: debug|release

* According the wiki automated script, steps are:
  `git clone … && cd … && cmake-gui . && cmake . && make`
  * RTFM: What to do in `cmake-gui` once it's started?

* Use a build target [outside of the source repo](https://www.freecadweb.org/wiki/CompileOnUnix#Out-of-source_build)

* checkinstall make?



UI
--

* Maybe make a menu system to guide users?





