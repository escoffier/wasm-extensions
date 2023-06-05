#!/usr/bin/env bash

[[ -z "${SKIP_PROTO_FORMAT}" ]] && tools/proto_format/proto_format.sh fix

bazel_or_isk=bazelisk
command -v bazelisk &> /dev/null || bazel_or_isk=bazel

[[ -z "${EXCLUDE_CONTRIB}" ]] || opts="--exclude_contrib"

# Setting TEST_TMPDIR here so the compdb headers won't be overwritten by another bazel run
# TEST_TMPDIR=${BUILD_DIR:-/home/qiuqf/workspace/istio}/wasm-cnaf-compdb tools/gen_compilation_database.py --vscode --bazel=$bazel_or_isk ${opts} "//extensions/grpc_logging:grpc_logging.wasm"
#TEST_TMPDIR=${BUILD_DIR:-/home/qiuqf/workspace/istio}/wasm-cnaf-compdb tools/gen_compilation_database.py --vscode --bazel=$bazel_or_isk ${opts} "//extensions/open_policy_agent:open_policy_agent.wasm"
#TEST_TMPDIR=${BUILD_DIR:-/home/qiuqf/workspace/istio}/wasm-cnaf-compdb tools/gen_compilation_database.py --vscode --bazel=$bazel_or_isk ${opts} "//source/open_policy_agent/..."
TEST_TMPDIR=${BUILD_DIR:-/home/qiuqf/workspace/istio}/wasm-cnaf-compdb tools/gen_compilation_database.py --vscode --bazel=$bazel_or_isk ${opts} "//extensions/..."

# Kill clangd to reload the compilation database
pkill clangd || :
