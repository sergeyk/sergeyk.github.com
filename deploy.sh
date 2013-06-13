CUR_BRANCH=`git rev-parse --abbrev-ref HEAD`
if [ $CUR_BRANCH='source' ]; then
    git push origin source

    jekyll build
    git checkout master
    git rm -qr .
    cp -r _site/. .
    rm -r _site
    git add -A
    git commit -am `git log --oneline -1`
    git push origin master
fi
