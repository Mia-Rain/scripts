#!/bin/sh
cd /var/www/git-http
eval $(keychain --eval --agents ssh  id_ed25519)

[ "$1" ] && {
  [ -d ./$1 ] || git clone ssh://g.posix.gay/$1
  cd $1 && {
    git pull
    [ -e "./custom-http" ] && c="./custom-http"
    [ ! -e ./index.html -a -e ./README ] && {
      /var/www/git-http/Mitl-gen/gen ${c} < ./README > ./index.html
    } || {
      mv ./index.html ./index.bk
      /var/www/git-http/Mitl-gen/gen ${c} < ./README > ./index.html
    } 
  }
  exit 0
} || {
  for i in ./*; do
    [ -d "$i" ] && {
      cd $i && {
	git pull || echo "error @ $i"
    	[ -e "./custom-http" ] && c="./custom-http"
	[ ! -e "./index.html" -a -e ./README ] && {
	  /var/www/git-http/Mitl-gen/gen ${c} < ./README > ./index.html
	} || {
	  [ -e ./README ] && {
	    mv ./index.html ./index.bk
	    /var/www/git-http/Mitl-gen/gen ${c} < ./README > ./index.html	
	    i=0; [ -e "./desc" ] || while read -r p || [ "$p" ]; do
    	      [ "$i" -eq 2 ] && printf '%s\n' "${p#--?}" > ./description
	      : $((i+=1))
	    done < ./README
	  } || echo "$i has no README"
    	}
	unset c
	cd ../
      }
    }
  done
}
cd
