#!/usr/bin/env bash
#########################################################################
# File Name: start.sh
# Author: Peng Li
# Mail: pengli09@gmail.com
# Created Time: 2025-10-21 15:04:14
#########################################################################

# 默认不启用 -D
INCLUDE_DRAFTS=false
# 默认复用cache
IGNORE_CACHE=false

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -d|--drafts)
            INCLUDE_DRAFTS=true
            shift
            ;;
        -ic|--ignoreCache)
            IGNORE_CACHE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--drafts|-d]"
            exit 1
            ;;
    esac
done

# 构建命令
CMD="hugo server --disableFastRender"

if [ "$INCLUDE_DRAFTS" = true ]; then
    CMD="$CMD -D"
fi

if [ "$IGNORE_CACHE" = true ]; then
    CMD="$CMD --ignoreCache"
fi

# 执行命令
echo "Running: $CMD"
eval "$CMD"

