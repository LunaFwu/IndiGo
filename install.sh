#!/bin/bash

if [ "$(uname)" != "Darwin" ]; then
  echo "This script is intended for macOS only."
  exit 1
fi

if pgrep IndiGo > /dev/null; then
  echo "IndiGo is running, closing it..."
  kill -9 $(pgrep IndiGo)
fi

architecture=$(uname -m)
if [[ "$architecture" == "arm64" ]]; then
  url="https://github.com/LunaFwu/IndiGo/releases/download/v1/IndiGo-v1-arm64-mac.zip"
elif [[ "$architecture" == "x86_64" ]]; then
  url="https://github.com/LunaFwu/IndiGo/releases/download/v1/IndiGo-v1-mac.zip"
else
  echo "Unsupported architecture: $architecture"
  exit 1
fi

mkdir -p "/tmp/IndiGo"
if [ -d "/Applications/IndiGo.app" ]; then
  echo "IndiGo is already installed. Deleting..."
  rm -rf "/Applications/IndiGo.app"
  echo "IndiGo has been deleted."
else
  echo "IndiGo is not installed. Proceeding with installation."
fi

echo "Downloading IndiGo for $ARCH..."
curl -L -o "/tmp/IndiGo/IndiGo.zip" "$url"
echo "Extracting IndiGo..."
unzip -o "/tmp/IndiGo/IndiGo.zip" -d "/tmp/IndiGo"
mv -f "/tmp/IndiGo/IndiGo.app" "/Applications"
rm -rf "/tmp/IndiGo"

echo "IndiGo has been successfully installed!"