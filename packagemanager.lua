-- Module LaTeX package Manager
-- This is essential only for managing order
-- of packages.
-- 
-- We cater for fonts etc..


local packagemanager = {}

-- All packages catered by the program are
-- in a local store
-- each package has the following fields

local ltxpackage = {}

ltxpackage.name = 'longtable'
ltxpackage.description = 'Manages long tables'
ltxpackage.version = 'v13.07.02'

local ltxpackages = {
  longtable = {
      name = 'longtable',
      description = [[
      This package defines the longtable environment, a multi-page version of
      tabular
      ]],
      version = '',
      constraints = {
      location = "beforehyper",
      conflicts = ''  
    },
    categories = 'tables'
  },
  
   
  numprint = {
      name = 'numprint',
      description = [[
      The package numprint prints numbers with a separator every three digits and converts numbers given as 12345.6e789 to 12\,345,6\cdot 10^{789}. Numbers are printed in the current mode (text or math) in or­der to use the cor­rect font.
Many things, including the decimal sign, the thousand sep­a­ra­tor, as well as the prod­uct sign can be changed by the user, e.g., to reach 12,345.6\times 10^{789}.
If an optional argument is given it is printed upright as unit. Numbers can be rounded to a given num­ber of dig­its. The package supports an automatic, language-dependent change of the number format.

Tabular align­ment using the tabular(*), array, tabularx, and longtable environments (similar to the dcolumn and rccol packages) is sup­ported us­ing all features of numprint. Additional text can be added be­fore and after the formatted number.
      ]],
      version = '',
      constraints = {
      location = "beforehyper",
      conflicts = ''  
    },
    categories = 'number formatters',
    author = "Harald Harders",
    date   = "20-08-2012",
    version = "1.39"
    }, 
  }

ltxpackages.tabularx = {
   name = 'tabularx',
      description = [[
      Tabular x
      ]],
      version = '',
      constraints = {
      location = "beforehyper",
      conflicts = ''  
    },
    categories = 'tables',
    author = "",
    date   = "",
    version = ""
      
  }


print(ltxpackages.longtable.description)
print(ltxpackages['tabularx'].description)

return packagemanager