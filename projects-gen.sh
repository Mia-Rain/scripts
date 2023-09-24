#!/bin/sh
:> ./projects-list
for i in /var/www/git-http/*; do
  [ -e "${i}/README" -a ! -e "${i}/dead" ] && {
    echo "${i}" >> ./projects-list
  } # don't display projects without READMEs
done
l=0; n=0; while read -r p || [ $p ]; do 
  : $((l+=${#p})) # add length of lines together
  : $((n+=1))     # count lines
done < ./projects-list
l=$((l/n +30))
[ $l -lt 45 ] && l=48
printf '</body>'
(
printf '<head>
<link rel="icon" href="/favicon.png">
<link rel="stylesheet" href="/style.css">
<link rel="stylesheet" href="/projects-css">
<title>~git/projects</title>
</head>
<body class="vsc-initialized">'
printf '<div class="float">'
printf '<font>
<pre>
    |
    | ~ Projects
'
printf '%s+' "----";
n=0; until [ "$n" -eq "${l:-0}" ]; do 
  printf '-'
  : $((n+=1))
done; echo
printf '<div class="items">'
while read -r p || [ "$p" ]; do
  sp="${p#/var/www/git-http/}"
  [ -e "${p}/README" ] && {
    printf '    | -- <a href="/%s">%s</a>\n' "$sp" "$sp"
    [ -e "${p}/desc" -o -e "${p}/description" ] && {
      [ -e "${p}/description" ] && read -r pp < ${p}/description
      [ -e "${p}/desc" ] &&  read -r pp < ${p}/desc
      echo "    | ---- ${pp}"
    }
  } # don't display projects without READMEs
done < ./projects-list
printf '</div></pre>
</font>
</div>
</body>'
) > projects/index.html
