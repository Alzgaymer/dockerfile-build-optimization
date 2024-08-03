#!/bin/sh

echo "Target binary: $TARGET_BINARY"

if [ "$TARGET_BINARY" = "server" ]; then
    go run cmd/server/main.go
    elif [ "$TARGET_BINARY" = "consumer" ]; then
    go run cmd/consumer/main.go
    else
      echo "Unknown target binary: $TARGET_BINARY"
        exit 1
fi