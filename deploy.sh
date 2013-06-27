# Deploy to github by pushing the msater branch

CUR_BRANCH=`git rev-parse --abbrev-ref HEAD`
MSG=`git log --oneline -1`

if [ $CUR_BRANCH='source' ]; then
    git push origin source

    jekyll build
    git checkout master
    git rm -qr .
    cp -r _site/. .
    rm -r _site
    git add -A
    git commit -m "$MSG"
    git push origin master

    git checkout source
fi
