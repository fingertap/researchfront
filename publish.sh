#!/bin/bash

# Enable mathjax
[[ -f "book.json" ]] || echo '{"plugins":["mathjax"]}' > book.json
[[ -d "node_modules" ]] || gitbook install .

# Create branch for github pages
git branch -d gh-pages
git checkout --orphan gh-pages
# Replace $ with $$ for inline math blocks
find . -path ./node_modules -prune -o -name "*.md" -exec sed -i '' 's/\$/$$/g' {} +
find . -path ./node_modules -prune -o -name "*.md" -exec sed -i '' 's/\$\$\$\$/$$/g' {} +
# Build the htmls
## First remove the files except _book
gitbook build
git rm --cache -r .
git clean -df
rm -rf *~
echo "*~" > .gitignore
echo "_book" > .gitignore
echo "node_modules" > .gitignore
echo "publish.sh" > .gitignore