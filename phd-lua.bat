echo PHD-LUA COMMAND LINE 
rem primarily for using dtx files with shell shell-escape
rem in order to use minted  


lualatex -shell-escape %~n1%~x1
biber %1
makeindex -s phd.ist %~n1.idx 
lualatex -shell-escape %~n1%~x1
makeindex -s phd.ist %~n1.idx
lualatex -shell-escape %~n1%~x1

rem do some clean up docstrip cannot fix this
copy %~n1.md .\docs
del %~n1.md
echo Now loading pdf
%~n1.pdf