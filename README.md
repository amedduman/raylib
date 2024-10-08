# raylib
raylib...


#!/bin/bash
set -euo pipefail

# Navigate to emsdk directory and source the environment
cd ./emsdk
source emsdk_env.sh
cd ..

# Navigate to src directory
cd ./src

# Check if resources directory exists
if [ -d "resources" ]; then
    PRELOAD_OPTION="--preload-file resources"
else
    echo "Warning: resources directory not found. Skipping preload."
    PRELOAD_OPTION=""
fi

# Compile the project
emcc -o ../out/index.html \
    main.c -Os -Wall \
    -I. -I ../include \
    -L. -L ../lib \
    -s USE_GLFW=3 \
    -s ASYNCIFY \
    --shell-file ../shell.html \
    $PRELOAD_OPTION \
    -s TOTAL_STACK=64MB \
    -s INITIAL_MEMORY=128MB \
    -s ASSERTIONS \
    -DPLATFORM_WEB \
    -lraylib \
    -s EXPORTED_FUNCTIONS='["_main", "_malloc"]' \
    -s EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' \
    -s ERROR_ON_UNDEFINED_SYMBOLS=0

# Navigate to out directory
cd ../out

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Try to run the compiled output with an available browser
if command_exists xdg-open; then
    xdg-open index.html
elif command_exists google-chrome; then
    google-chrome index.html
elif command_exists firefox; then
    firefox index.html
else
    echo "No suitable browser found. Please open 'out/index.html' manually in your preferred web browser."
fi

echo "Build complete. Output files are in the 'out' directory."