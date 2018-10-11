# The `phd` LaTeX2e package

The `phd` latex package and the class with the same name provide
convenient methods to create new styles for books, reports
and articles. It also loads the most commonly used packages
and resolves conflicts.

This work consists of the file  `phd.dtx`,
and the derived files   `phd.ins`,  `phd.pdf`, and `phd.sty`.

The `phd` bundle is a bunch of 15 packages, that manage all
aspects of document production.

They consist of:

1.0  The [phd-pkgmanager](https://github.com/yannisl/phd/blob/master/docs/phd-pkgmanager.md). This
     package manages all aspects of loading numerous packages and avoiding conflicts. It currently
     loads over 100 packages, directly or indirectly.

2.0  The [phd-fontmanager](https://github.com/yannisl/phd/blob/master/docs/phd-fontmanager.md). The
     `phd-fontmanager` sets up the fonts to be used for the document and provides an interface to
     all areas where font data is needed.

3.0  The [phd-handlers](https://github.com/yannisl/phd/blob/master/docs/phd-handlers.md). As we use
     extensively automatic key generation via code, this package provides numerous handlers.

4.0  The [phd-lowerlevelheadings](https://github.com/yannisl/phd/blob/master/docs/phd-lowerlevelheadings.md)

5.0  The [phd-toc](https://github.com/yannisl/phd/blob/master/docs/phd-toc.md) package.
     Manages all aspects of Table of Contents via a key value interface.

6.0  The [phd-counters](https://github.com/yannisl/phd/blob/master/docs/phd-counters.md)

7.0  The [phd-colorpalette](https://github.com/yannisl/phd/blob/master/docs/phd-colorpalette.md). This
     package introduces the concept of a `color palette` to `LaTeX` coding. It groups all color
     data into `palettes`. By setting a single set of keys, the document can be updated with new
     color information.

8.0  The [phd-scriptsmanager](https://github.com/yannisl/phd/blob/master/docs/phd-scriptsmanager.md).
     Handles the settings and provides a key face interface to over scripts for use in typesetting
     texts from ancient to modern.

9.0  The [phd-documentation](https://github.com/yannisl/phd/blob/master/docs/phd-documentation.md).
     Provides numerous commands and keys for typesetting code. It also provides indexing shortcuts,
     including math symbols etc.

10.0 The [phd-epigraphs](https://github.com/yannisl/phd/blob/master/docs/phd-epigraphs.md).
     This package manages the typesetting of epigraphs.

11.0 The [phd-frontmatter](https://github.com/yannisl/phd/blob/master/docs/phd-epigraphs.md)
     package for the typesetting of frontmatter such as coverpages, copyright pages and title
     pages.

12.0 The [phd-lorems](https://github.com/yannisl/phd/blob/master/docs/phd-lorems.md)
     package. Provides some additional commands for filler text.

13.0 The [phd-quote](https://github.com/yannisl/phd/blob/master/docs/phd-quote.md)
     package. Provides some additional commands for filler text.

14.0 The [phd-lists](https://github.com/yannisl/phd/blob/master/docs/phd-lists.md)
     package. Provides some additional commands and a key value interface for lists.

15.0 The [phd-logos](https://github.com/yannisl/phd/blob/master/docs/phd-logos.md)
     package. Supplementary commands for logos.

###Installation

run
        `phd-lua phd-i18n.dtx` on windows

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

      \usepackage{phd-i18n}
      \input{style13}

All choices, are made via an extended key-value interface.
Although not a compliment, it resembles CSS and the keys are a bit verbose but
attributes are easy to change and have a consistent and easy to remember interface.

To set or add a key we only use one command:

      \cxset{chapter name font-size: Huge,
             chapter number font-size: HUGE}

### Future Development

This is still an experimental version, but I will retain the
interface in future releases. There is a large amount of
work still to be carried out to improve the template styles
provided, to test it more thoroughly and to add a number of
improvements in the special designs. At present I estimate
that I have completed about 70% of the work that needs
to be done.

__The package as it stands is not production stable.__

