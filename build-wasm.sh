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

# Run the compiled output
emrun index.html















# #!/bin/bash
# set -euo pipefail

# cd ./emsdk
# source emsdk_env.sh
# cd ../
# cd ./src

# emcc -v -o ../out/index.html \
#     main.c -Os -Wall main.c \
#     -I. -I ../include \
#     -L. -L ./lib \
#     -s USE_GLFW=3 \
#     -s ASYNCIFY \
#     --shell-file ../shell.html \
#     --preload-file resources \
#     -s TOTAL_STACK=64MB \
#     -s INITIAL_MEMORY=128MB \
#     -s ASSERTIONS \
#     -DPLATFORM_WEB

# cd ../out
# # BUILD_NAME="$(date -u +"%Y-%m-%d")"
# # zip "${BUILD_NAME}.zip" index.html index.js index.wasm index.data

# emrun index.html