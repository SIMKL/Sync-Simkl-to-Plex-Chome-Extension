### TODO

#### `@phanirithvij`

- [x] API methods
  - [x] Oauth
    - [x] Plex get authtoken
    - [x] Simkl get authtoken
    - [x] Control flow
      - [x] Connect APIs to Plex, Simkl buttons
      - [x] Show errors/info messages in UI
      - [x] Reopening popup should resume state, use `localStorage` for persistance.
        - This is not an issue when in full tab
  - [x] Simkl
    - [x] Full history endpoint
    - [x] Query based on last synced timestamp
      - check what this endpoint is in docs
  - [x] Plex
    - [x] List out local libraries and their entries
    - [x] Update a library info and entry info and status
    - [x] Decide on how content is matched in simkl and plex
- [x] Ask user to setup syncing options
  - [x] Every `x` hrs
- [x] Open popup in a full tab for the first time
  - [x] `chrome.runtime.onInstalled`
  - [x] concluded to be not needed ~~Add thanks for install message conditionally if in full tab.~~
- [x] Redirect to uninstalled feedback page once uninstalled.
- [ ] All the other minor todos and fixmes scattered across the code.
- [x] Nix flake only for dev.
  - ci should not use nix! (lack of win support and not everyone knows of it)
- [x] a script to launch chromium/firefox with extension installed
  - [ ] normal usage of extension in existing browser. (to avoid any bugs which occur in non-fresh installs)
- [ ] windows scripts
  - [ ] maintain (test) via github actions
- [ ] tests, interactive, playwright? see datastar
  - firefox, chrome
- [ ] matrix test (win, mac, linux) in gha
- [ ] test flows
  - [ ] plex login (real test acc)
  - [ ] simkl login (real test acc)
  - [ ] Install and uninstall flow capture videos in automated testing!
  - https://playwright.dev/docs/videos
  - https://playwright.dev/docs/chrome-extensions

Bugs

- [x] simkl connect flow is broken!!
- [x] some request repeated too many times thing

#### `@masyk`

- [x] UX/UI
- [ ] Extension uninstall feedback (internal simkl.com) page
  - placeholder https://simkl.com/apps/chrome/plex/goodbye/
- [x] (not needed) Php code for proxying plex oauth requests
  - This would get rid of the warning message shown by plex's oauth screen.
  - Not needed I guess, let the warning stay.
- [x] Extension icon, name, description
