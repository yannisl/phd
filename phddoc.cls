%%
%% This is file `phddoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% phddoc.dtx  (with options: `class')
%% ----------------------------------------------------------------
%% phddoc --- A class to typeset LaTeX code.
%% E-mail: yannislaz@gmail.com
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% ----------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3,xparse}
\RequirePackage{l3keys2e}
\ProvidesClass{phddoc}
         [2018/12/13 v1.0 LaTeX documentation class (YL)]



\ExplSyntaxOn
\cs_gset:Npn \l_phd_version{1.00}
\ExplSyntaxOff
\ExplSyntaxOn
\bool_new:N \g__phdcl_macrocode_colorize_bool
\bool_new:N \g__phdcl_book_bool
\bool_new:N \g__phdcl_article_bool
\bool_new:N \g__phdcl_report_bool
\bool_new:N \g__phdcl_scrbook_bool
\bool_new:N \g__phdcl_scrartcl_bool
\bool_new:N \g__phdcl_scrreprt_bool
\bool_new:N \g__phdcl_masterthesis_bool
\bool_new:N \g__phdcl_ldoc_bool
\bool_new:N \g__phdcl_ldociii_bool
\ExplSyntaxOff

\ExplSyntaxOn
\bool_if:NTF \g__phdcl_macrocode_colorize_bool
  {\bool_gset_true:N \phdd_code_colorize_bool}
  {\bool_gset_false:N \phdd_code_colorize_bool}
\DeclareOption{a5paper}{\@latexerr{Option not supported}%
   {}}

\DeclareOption { full }
  {
    \bool_gset_true:N \g_phdd_typeset_documentation_bool
    \bool_gset_true:N \g_phdd_typeset_implementation_bool
  }
\DeclareOption { onlydoc }
  {
    \bool_gset_true:N \g_phdd_typeset_documentation_bool
    \bool_gset_false:N \g_phdd_typeset_implementation_bool
  }
\DeclareOption{colorize}
  {\bool_gset_true:N \phdd_code_colorize_bool}
\DeclareOption { check }
  { \bool_gset_true:N \g__phdcl_checkfunc_bool }
\DeclareOption { nocheck }
  { \bool_gset_false:N \g__phdcl_checkfunc_bool }
\DeclareOption { checktest }
  { \bool_gset_true:N \g__phdcl_checktest_bool }
\DeclareOption { nochecktest }
  { \bool_gset_false:N \g__phdcl_checktest_bool }
\DeclareOption { kernel }
  { \bool_gset_true:N \g__phdcl_kernel_bool }
\DeclareOption { stdmodule }
  { \bool_gset_false:N \g__phdcl_kernel_bool }
\DeclareOption { cm-default }
  { \bool_gset_false:N \g__phdcl_lmodern_bool }
\DeclareOption { lm-default }
  { \bool_gset_true:N \g__phdcl_lmodern_bool }
\DeclareOption { cs-break-off }
  { \bool_gset_false:N \g__phdcl_cs_break_bool }
\DeclareOption { cs-break-nohyphen }
  { \PassOptionsToPackage{nohyphen}{underscore} }

\tl_new:N \g__phdcl_doctype_tl
\DeclareOption {book}
  {\tl_gput_right:Nn \g__phdcl_doctype_tl{book} }

\DeclareOption {scrbook}
  {\tl_gput_right:Nn \g__phdcl_doctype_tl{book} }

\DeclareOption* { \PassOptionsToClass { \CurrentOption } { book } }
\ExecuteOptions { full, kernel, nocheck, nochecktest, lm-default }
\PassOptionsToClass { a4paper } { book }


\ExplSyntaxOn
\msg_new:nnn { phddoc } { input-cfg }
  { Local~config~file~phddoc.cfg~loaded. }
\file_if_exist:nTF {phddoc.cfg}
  {
    \file_input:n {phddoc.cfg}
  }
  { \msg_info:nn { phddoc } { input-cfg }  }
  {}
\ExplSyntaxOff

\ExplSyntaxOn
\str_case_e:nnTF { \g__phdcl_doctype_tl }
   {
     { book     }    {
                       %\LoadClass{book}
                       \bool_gset_true:N \g__phdcl_book_bool

                     }
     { article  }    {
                       %\LoadClass{article}
                       \bool_gset_true:N \g__phdcl_article_bool
                     }
     { report        } {
      %\LoadClass{report}
      \bool_gset_true:N \g__phdcl_report_bool
       }
     { scrbook       } {
                         %\LoadClass{scrbook}
                         \KOMAoptions{twoside = false}
                         \bool_gset_true:N \g__phdcl_scrbook_bool
                       }
     { scrartcl      } {
                         %\LoadClass{scrartcl}
                         \bool_gset_true:N \g__phdcl_scrartcl_bool
                       }
     { l3doc         } { %\LoadClass{l3doc}
                       }
     { masterthesis  } {                         }
     { tufte         } {                         }
     { ltxdoc        } {                         }
     { l3doc         } {                         }
     { memoir        } { %\LoadClass{memoir}
                                                }
   }
   {                                             }
   { }

\ExplSyntaxOff
\ExplSyntaxOn
\ProcessOptions
\LoadClass{\g__phdcl_doctype_tl}
\ExplSyntaxOff


\RequirePackage{doc}
\RequirePackage{phd}
\RequirePackage{phd-pkgmanager}
\sethyperref
\RequirePackage{phd-documentation} %modifies doc as necessary
\RequirePackage{phd-colorpalette}
\RequirePackage{phd-runningheads}
\RequirePackage{phd-toc}

\AtBeginDocument{\MakeShortVerb{\|}}
\DeclareFontShape{OT1}{cmss}{m}{it}{<->ssub*cmss/m/sl}{}
\CodelineIndex
\CodelineNumbered
\EnableCrossrefs
\setcounter{StandardModuleDepth}{1}
\def\cmd#1{\cs{\expandafter\cmd@to@cs\string#1}}
\def\cmd@to@cs#1#2{\char\number`#2\relax}

\DeclareRobustCommand\cls{\textcolor{thered}}

\providecommand\parg[1]{%
  {\ttfamily(}\meta{#1}{\ttfamily)}}
\@addtoreset{CodelineNo}{chapter}
\def\partname{File}
\def\task#1#2{}
\endinput
%%
%% End of file `phddoc.cls'.
