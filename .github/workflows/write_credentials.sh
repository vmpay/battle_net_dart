#!/bin/sh

# Remove old file first
rm test/credentials.dart
# Create a replacement
printf "const String clientId = '%s';\nconst String clientSecret = '%s';" "$CLIENT_ID" "$CLIENT_SECRET" >> test/credentials.dart