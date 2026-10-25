# tasict/homebrew-tap

Homebrew casks for apps by tasict.

## Turnout

[Turnout](https://turnout.ctsite.cc/) is a VPN client for macOS that connects to WireGuard servers and lets you choose which network interface each tunnel's traffic leaves through.

```sh
brew install --cask tasict/tap/turnout
```

- Turnout opens after installing and walks you through its setup: it runs its tunnels in a background service, which macOS asks you to allow once in System Settings › General › Login Items & Extensions.
- Turnout updates itself, so `brew upgrade` leaves it alone. `brew upgrade --greedy` reinstalls it, and the background service then has to be allowed again.
- Turnout is paid: every Mac gets a 7-day trial, then one license covers three Macs. See the [license terms](https://turnout.ctsite.cc/license.html).
- `brew uninstall --cask turnout` removes Turnout, its background service and its settings; saved tunnels stay in `/Library/Application Support/cc.ctsite.turnout` until you delete that folder. `--zap` also removes caches and saved window state.

Problems and questions: [github.com/tasict/Turnout/issues](https://github.com/tasict/Turnout/issues).
