#!/usr/bin/env bash
# Idempotent Cloud Agent bootstrap for this Jekyll site.
# The default base image ships without a Ruby toolchain, so provision one here.
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v ruby >/dev/null 2>&1; then
  echo "==> Installing Ruby toolchain..."
  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ruby-full build-essential zlib1g-dev libyaml-dev libffi-dev
fi

if ! command -v bundle >/dev/null 2>&1; then
  echo "==> Installing Bundler..."
  sudo gem install bundler
fi

echo "==> Installing gem dependencies..."
bundle config set --local path 'vendor/bundle'
bundle install

echo "==> Environment ready."
