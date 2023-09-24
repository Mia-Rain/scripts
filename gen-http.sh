#!/bin/sh
header='<head>
<link rel="icon" href="/favicon.png">
<link rel="stylesheet" href="/style.css">
<title>~git/scripts</title>
</head>
<body class="vsc-initialized"><font color="#fffff">
<pre style="background-color: black">    |
    |
----+-----------------------------------------------------
    | ---
    | SH.POSIX.gay!
    | -- tiny scripts that cant have full projects
    | ---
    | Scripts'
footer='    | ---
    |
    |
    |
</pre>
</font>
</body>'
echo "$header"
for i in ./*.sh; do
  printf '    | -- <a href="%s">%s</a>\n' "${i#.}" "$i"
done
echo "$footer"
