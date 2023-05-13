#!/bin/bash

# Prompt the user to input file names
echo "Enter the names of the input video files (separated by spaces):"
read -a inputFiles

# Output file extension
outputExtension=".mp4"

# Iterate over input file names
for inputFile in "${inputFiles[@]}"
do
  # Get the base filename without the path
  inputFileName=$(basename "$inputFile")
  
  # Resize the video
  echo "Resizing video: $inputFileName"
  outputFileName="output_${inputFileName%.*}$outputExtension"
  ffmpeg -i "$inputFile" -vf "scale=-1:1920,crop=1080:1920" "$outputFileName"
  
  # Check if resizing was successful
  if [ $? -ne 0 ]; then
    echo "Failed to resize the video: $inputFileName"
  else
    echo "Video resized successfully: $inputFileName"
    echo "Output file: $outputFileName"
  fi
done

echo "All videos resized."
