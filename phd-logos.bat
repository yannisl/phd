lualatex phd-logos.dtx
bibtex
makeindex -s phd.ist phd-logos.idx
lualatex phd.dtx
makeindex -s phd.ist phd-logos.idx
lualatex phd-logos.dtx

