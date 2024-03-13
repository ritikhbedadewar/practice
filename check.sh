#sed -i 's/simplespringapp3/changed ap name/g' $(find . -type f \( -name "*.yaml" -o -name "*.yml" -o -name "*.properties" \))
# git add .
# git commit -m "Replace 'old_text' with 'new_text'"
# git push origin main
# SEARCH_TEXT="simplespringapp3"
# REPLACE_TEXT="changed ap name"
# # Search and replace text in YAML and property files
# find . -type f \( -name "*.yaml" -o -name "*.yml" -o -name "*.properties" \) -exec sed -i "s/$SEARCH_TEXT/$REPLACE_TEXT/g" {} +

# Commit and push changes using GitHub CLI
# git add .
# git commit -m "Replace '$SEARCH_TEXT' with '$REPLACE_TEXT'"
# gh repo view -w
# gh repo sync
#!/bin/bash

# Directory where your repository is located
REPO_DIR="."

# Key to find and replace
KEY="app-name"

# Replacement value
NEW_VALUE="null"

# Find and replace in YAML files
find "$REPO_DIR" -type f \( -name '*.yaml' -o -name '*.yml' \) -exec sed -i "s/$KEY:.*/$KEY: $NEW_VALUE/g" {} +

# Find and replace in properties files
find "$REPO_DIR" -type f -name '*.properties' -exec sed -i "s/$KEY=.*/$KEY=$NEW_VALUE/g" {} +

echo "Replacement completed."


