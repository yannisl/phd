###The `phd-scriptsmanager` LaTeX2e package version 0.08.0

The `phd-scriptsmanager` latex package and the class
with the same name provide
convenient methods to create new styles for books, reports
and articles. It also loads the most commonly used packages
and resolves conflicts.

This work consists of the file

     `phd-scriptsmanager.dtx`,

and the derived files

     `phd-scriptsmanager.ins`,
     `phd-scriptsmanager.pdf`,

     and

     `phd-scriptsmanager.sty`.

###Installation

The documentation of this package uses numerous fonts not available in a
normal `TeX` distribution. Before you regenerate it, make sure you install these
fonts first. All fonts are with an open source license.

The fonts we require for the `phd` system to be fully functional and capable
to typeset almost _any_ script or language that existed or is still live are
the following:

- The [noto](https://www.google.com/get/noto/) fonts from Google. the fonts
  are licenced under the [Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)  or the [SIL Open Font License, Version 1.1]. Download and
  install all the fonts.

- The ancient fonts provided by [George Douros](http://users.teilar.gr/~g1951d/).

- The Tiresias PCfont font from  [Tiresias](http://www.tiresias.org/fonts/). This font
  is not actually used for scripts, but for experiments in readability. It looks
  very good for headings. The aim of this organization is to make Information
  Communication Technologies accessible to blind and partially sighted people. This
  I thought was a good opportunity to promote their work.

- code2000.ttf and code2001.ttf

- Shonar Bangla font.

- Vrinda

If you have Windows

- Microsoft JhengHei and SimSun

There are many more fonts, I will revisit these docs to provide full documentation.

Once you ready then

run

      `phd-lua.bat` on windows

If you have any difficulties with the package come and join us at
http://tex.stackexchange.com and post a new question or
add a comment at http://tex.stackexchange.com/a/45023/963.
or send me a message at  yannislaz at gmail.com

### Documentation

The package was written using the `doc` and `docscript` packages,
so that it is self documented in a literary programming style.
The .pdf is a fat document, providing over fifty book styles (the
equivalent of classes) plus there is a lot of write-up on the inner
workings of TeX and LaTeX2e. However, you don't need to know much
to use it.

      \usepackage{phd}
      \input{style13}

All choices, are made via an extended key-value interface.
Although not a compliment, it resembles CSS and the keys are a bit verbose but
attributes are easy to change and have a consistent and easy to remember interface.

To set or add a key we only use the command `\cxset`:

      \cxset{chapter name font-size = Huge,
             chapter number font-size = HUGE}

### Future Development

This is still an experimental version, but I will retain the
interface in future releases. There is a large amount of
work still to be carried out to improve the template styles
provided, to test it more thoroughly and to add a number of
improvements in the special designs. At present I estimate
that I have completed about 70% of the work that needs
to be done.

__The package as it stands is not production stable.__




