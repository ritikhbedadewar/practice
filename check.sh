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

# GitHub repository information
REPO_OWNER="ritikhbedadewar"
REPO_NAME="practice"
BRANCH_NAME="main"  # or specify the branch you want to work with
SEARCH_KEY="app-name"
REPLACE_KEY="app-name"
REPLACE_VALUE="new_value"
GITHUB_TOKEN="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"

# Function to search and replace key-value pair
search_replace() {
    updated_content=$(echo "$1" | sed "s/$SEARCH_KEY: .*/$REPLACE_KEY: $REPLACE_VALUE/")
    echo "$updated_content"
}

# Function to update file in repository
update_file() {
    file_path="$1"
    content="$2"
    sha="$3"
    url="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/contents/$file_path"
    data="{\"message\": \"Update key-value pair '$SEARCH_KEY' with '$REPLACE_KEY: $REPLACE_VALUE'\", \"content\": \"$(echo -n "$content" | base64)\", \"sha\": \"$sha\", \"branch\": \"$BRANCH_NAME\"}"
    curl -s -X PUT -H "Authorization: token $GITHUB_TOKEN" -H "Accept: application/vnd.github.v3+json" -d "$data" "$url" > /dev/null
}

# Get list of files in repository
files_url="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/trees/$BRANCH_NAME?recursive=1"
response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" -H "Accept: application/vnd.github.v3+json" "$files_url")
files=$(echo "$response" | jq -r '.tree[] | select(.type == "blob") | .path')

# Process files in repository
for file_path in $files; do
    if [[ $file_path == *.yaml || $file_path == *.yml || $file_path == *.properties ]]; then
        content=$(curl -s -H "Authorization: token $GITHUB_TOKEN" -H "Accept: application/vnd.github.v3+json" "https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH_NAME/$file_path")
        updated_content=$(search_replace "$content")
        sha=$(echo "$response" | jq -r --arg file_path "$file_path" '.tree[] | select(.type == "blob" and .path == $file_path) | .sha')
        update_file "$file_path" "$updated_content" "$sha"
        echo "Updated key-value pair in file: $file_path"
    fi
done