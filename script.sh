#!/bin/bash

# Confluence credentials and page information
USERNAME="your_username"
PASSWORD="your_password" / API_TOKEN= "your_api_token"
BASE_URL="https://your-confluence-instance.atlassian.net/wiki"
PAGE_ID="123456789"  # Replace with the ID of the page you want to append content to

# Content to append to the page
APPEND_CONTENT="<h2>New Content</h2><p>This is the content to be appended to the Confluence page.</p>"

# API endpoint for appending content to a page
URL="${BASE_URL}/rest/api/content/${PAGE_ID}/child/page"

# Request headers
HEADERS=(
    "Content-Type: application/json"
)

# Request data
DATA=$(cat <<EOF
{
  "type": "page",
  "title": "Append Content",
  "ancestors": [{"id": "${PAGE_ID}"}],
  "space": {"key": "SPACEKEY"},
  "body": {
    "storage": {
      "value": "${APPEND_CONTENT}",
      "representation": "storage"
    }
  }
}
EOF
)

# Send the request to append content to the page
RESPONSE=$(curl -s -u "${USERNAME}:${PASSWORD}" -X POST -H "${HEADERS[@]}" -d "${DATA}" "${URL}")

# Check if the request was successful
if [[ $? -eq 0 ]]; then
    echo "Content appended to the page successfully!"
else
    echo "Error appending content to the page: ${RESPONSE}"
fi
