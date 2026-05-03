# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Static Jekyll site for the **AI Behavioral Science Workshop** (annual workshop site, currently advertising the 2026 edition at Stanford SIEPR). Built on the [minimal-mistakes](https://mmistakes.github.io/minimal-mistakes/) theme — this repo *is* a fork/vendor of the theme, so the theme files (`_includes/`, `_layouts/`, `_sass/`, `assets/`, `docs/`, `test/`) live alongside the site content.

## Common commands

```sh
./serve.sh              # Local dev server at http://127.0.0.1:4000/ (auto-regen on edit)
lsof -ti:4000 | xargs kill   # Kill an orphaned server
```

Environment is rbenv + project-local `vendor/bundle`. See `SETUP.md` for the full setup. `serve.sh` injects `~/.rbenv/shims` into PATH so `bundle` resolves to Ruby 3.2.2 (not the system Ruby 2.6, which lacks bundler 2.4.22).

To run `bundle`/`jekyll` directly without the wrapper, prefix with `PATH="$HOME/.rbenv/shims:$PATH"` or `eval "$(rbenv init - zsh)"`.

The theme's Rakefile/`test/` and npm scripts in `package.json` are upstream theme tooling and are not used for site development.

## Architecture

**Site content is decoupled from theme code.** When editing the workshop site, almost all changes land in:

- `_config.yml` — site-wide config; `paginate`, `plugins`, `defaults`, `analytics`. Restart `./serve.sh` after editing (Jekyll does not hot-reload this file).
- `pages/<year>/index.md` — the per-year workshop page. Front matter sets `permalink: /<year>`, `layout: splash`, masthead, header overlay, and an inline `navigation:` list of in-page anchors (`#program`, `#organization`, etc.). Page body holds the program schedule, organizers, etc.
- `pages/relevant.md` — list of related workshops.
- `index.html` — root redirect to the current year (`/2026`). Update when bumping the active year.
- `_data/navigation.yml` — global nav (`main:` links shown in masthead).
- `_data/papers.yml` — accepted-papers data (per README; create if/when used).
- `assets/images/` — header/overlay images referenced from page front matter (e.g. `/assets/images/bg.png`).

**Theme code** (don't edit unless you mean to fork the theme):
- `_layouts/` — `splash.html` is the layout used by year pages; `single.html`, `home.html`, etc. for posts/archives.
- `_includes/` — partials (masthead, footer, head, etc.).
- `_sass/` and `assets/css/` — styles. Skin is set via `minimal_mistakes_skin` in `_config.yml`.

**Bumping to a new workshop year:**
1. Copy `pages/<prev-year>/index.md` → `pages/<new-year>/index.md`, update `permalink`, masthead, dates, navigation anchors, and program content.
2. Update `index.html` `meta refresh` URL to point at the new year.
3. Update `_data/navigation.yml` if the global nav references a year.

## Notes

- The Gemfile pins `jekyll <= 3.10.0`, `liquid <= 4.0.4`, `webrick <= 1.7`, and uses `github-pages` — kept compatible with GitHub Pages' build environment. Don't bump these without testing the GH Pages deploy.
- The site is served by GitHub Pages from `main` (no separate build step). The `_site/` directory is local-only output.
- `vendor/`, `.bundle/`, `.jekyll-cache/`, `_site/` are gitignored.
