#!/bin/bash

# Define the file path as a variable
CHAT_JS_FILE="/app/web/static/chat.js"

# Actual replacement
sed -i "s|http://0.0.0.0:8000|${APP_URL}|g" $CHAT_JS_FILE

# Check if the pattern with APP_URL already exists
if grep -q '("${APP_URL}/api/chat/init")' $CHAT_JS_FILE; then
  echo "Pattern with APP_URL already exists, doing nothing."

# Check if the pattern with the default URL exists
elif grep -q '("http://0.0.0.0:8000/api/chat/init")' "$CHAT_JS_FILE"; then
  echo "Replacing default URL with APP_URL."
  sed -i "s|http://0.0.0.0:8000|${APP_URL}|g" "$CHAT_JS_FILE"

# Check if the pattern n.get("api/chat/init") exists
elif grep -q 'n.get("/api/chat/init")' "$CHAT_JS_FILE"; then
  echo "Appending APP_URL to /chat/init."
  sed -i "s|n.get(\"/api/chat/init\")|n.get(\"${APP_URL}/api/chat/init\")|g" "$CHAT_JS_FILE"
fi

# Check if the pattern n.get("api/chat/init") exists
elif grep -q 'n.get("/chat/init")' "$CHAT_JS_FILE"; then
  echo "Appending APP_URL to /chat/init."
  sed -i "s|n.get(\"/chat/init\")|n.get(\"${APP_URL}/api/chat/init\")|g" "$CHAT_JS_FILE"
fi

# Start your app normally
exec "$@"