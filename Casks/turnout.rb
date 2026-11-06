cask "turnout" do
  version "1.1.4"
  sha256 "3f258371089496c15cfbad3727df80628ca338f3d862672f618d921c5f8dc9bf"

  # The website's stable address for the package, which it redirects to
  # wherever the releases are hosted (site/_redirects).
  url "https://turnout.ctsite.cc/download/v#{version}/Turnout-#{version}.pkg"
  name "Turnout"
  desc "VPN client that connects to WireGuard servers with wg-quick parity"
  homepage "https://turnout.ctsite.cc/"

  # The app's own update feed, the newest release's update.json.
  livecheck do
    url "https://turnout.ctsite.cc/latest/update.json"
    strategy :json do |json|
      json["version"]
    end
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
