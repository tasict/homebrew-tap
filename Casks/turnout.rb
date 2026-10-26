cask "turnout" do
  version "1.0.1"
  sha256 "92c79b5935410ff8866a93d092f0218b8b8d69289619ecd6049328dec841e63c"

  url "https://github.com/tasict/Turnout/releases/download/v#{version}/Turnout-#{version}.pkg"
  name "Turnout"
  desc "VPN client that connects to WireGuard servers with wg-quick parity"
  homepage "https://turnout.ctsite.cc/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sequoia

  pkg "Turnout-#{version}.pkg"

  # The uninstaller bundled in the app stops the background service (which
  # disconnects every tunnel and restores routes and DNS), takes it out of
  # Login Items, undoes what a crashed daemon left behind, and deletes the
  # app, its logs, the receipt and every user's preferences. It needs the app
  # still in place; Homebrew runs script: before pkgutil:, which is then only
  # a fallback. Saved tunnels are kept, as with Uninstall Turnout… in the app.
  uninstall script:  {
              executable: "/Applications/Turnout.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: "cc.ctsite.turnout"

  zap trash: [
    "~/Library/Caches/cc.ctsite.turnout",
    "~/Library/HTTPStorages/cc.ctsite.turnout",
    "~/Library/Preferences/cc.ctsite.turnout.plist",
    "~/Library/Saved Application State/cc.ctsite.turnout.savedState",
  ]

  caveats <<~EOS
    Turnout's tunnels run in a background service with root privileges.
    Turnout opens after installing, and its welcome tour walks you through
    installing the service and allowing it in
    System Settings › General › Login Items & Extensions.

    Turnout is paid: every Mac gets a 7-day trial, then one license covers
    three Macs. Turnout › License buys or enters one; the terms are at
    https://turnout.ctsite.cc/license.html
  EOS
end
