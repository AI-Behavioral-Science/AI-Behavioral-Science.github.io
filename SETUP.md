# Local dev environment

Isolated Ruby + gems for this site. Does not affect other projects.

## Stack
- **Ruby 3.2.2** via rbenv (auto-selected by `.ruby-version`)
- **Bundler 2.4.22** (already installed in this Ruby)
- **Gems** installed project-locally in `vendor/bundle/` (configured in `.bundle/config`, gitignored)

## One-time setup (already done)
1. `rbenv` via Homebrew → `brew install rbenv ruby-build`
2. `rbenv install 3.2.2` (pinned by `.ruby-version`)
3. `bundle config set --local path 'vendor/bundle'`
4. `bundle install`

## Run the dev server
```sh
./serve.sh
```
Site at http://127.0.0.1:4000/. Ctrl-C to stop.

`serve.sh` prepends `~/.rbenv/shims` to PATH so `bundle` resolves to rbenv's Ruby 3.2.2 (not system Ruby 2.6, which lacks bundler 2.4.22).

## Optional: skip the wrapper
Add to `~/.zshrc` so rbenv is active in every shell:
```sh
eval "$(rbenv init - zsh)"
```
Then `bundle exec jekyll serve` works directly.

## Reset
```sh
rm -rf vendor/ .bundle/  # nuke local gems
./serve.sh                # re-runs bundle install on next bundle exec
```

## Stop a server you forgot about
```sh
lsof -ti:4000 | xargs kill
```
