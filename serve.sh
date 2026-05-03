#!/usr/bin/env bash
# Local Jekyll dev server using rbenv-managed Ruby + project-local gems.
# Usage: ./serve.sh
set -e
export PATH="$HOME/.rbenv/shims:$PATH"
exec bundle exec jekyll serve "$@"
