sed -i 's/simplespringapp3/changed ap name/g' $(find . -type f \( -name "*.yaml" -o -name "*.yml" -o -name "*.properties" \))
git add .
git commit -m "Replace 'old_text' with 'new_text'"
git push origin master