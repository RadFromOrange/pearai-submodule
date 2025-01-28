#!/bin/bash

# Ensure a file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

FILE=$1
CHUNK_SIZE=99m  # 15 MB
REPO_URL="https://github.com/trypear/pearai-submodule"
DIST_DIR="/workspaces/continue/extensions/intellij/build/distributions"

# Navigate to the directory containing the file
cd $DIST_DIR || exit

# Zip the file into chunks of 15 MB
# zip -s $CHUNK_SIZE "${FILE}.zip" "$FILE"

# Wait for the zip command to complete


# Verify the chunks were created and list them
echo "Chunks created:"
rm -fr continue-intellij-extension-0.0.85.zip
ls -lh continue-intellij-extension-0.0.85.zip*

# Loop over all chunks
for CHUNK in $ls -lh continue-intellij-extension-0.0.85.zip*; do
  echo "Processing chunk: $CHUNK"

  # Add the zipped chunk file to git, forcing the addition
  git add -f "$CHUNK"
  
  # Commit the zipped chunk file
  git commit -m "Add zipped chunk $CHUNK of $FILE"
  
  # Push the commit
  git push
done

echo "All chunks have been zipped, committed, and pushed."