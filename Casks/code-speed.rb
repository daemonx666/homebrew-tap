# Homebrew cask for code-speed. packaging/render.sh fills in the version
# and checksum; the release workflow pushes it to daemonx666/homebrew-tap.
cask "code-speed" do
  version "0.1.2"
  sha256 "54e2bfc44b4a0d6cfa1fea8f68075656b546cb1bf2f1dca8815f985c6a119e94"

  url "https://github.com/daemonx666/code-speed/releases/download/v#{version}/code-speed-v#{version}-macos-universal.zip"
  name "Code Speed"
  desc "Live token speed, usage, cost and quotas of coding agents"
  homepage "https://github.com/daemonx666/code-speed"

  livecheck do
    url :url
    strategy :github_latest
  end

  # the app can install its own updates (Settings → System)
  auto_updates true
  depends_on macos: :ventura

  app "code-speed.app"

  uninstall quit:       "io.github.daemonx666.code-speed",
            launchctl:  "io.github.daemonx666.code-speed",
            login_item: "code-speed"

  zap trash: [
    "~/Library/Application Support/code-speed",
    "~/Library/Caches/io.github.daemonx666.code-speed",
    "~/Library/LaunchAgents/io.github.daemonx666.code-speed.plist",
    "~/Library/WebKit/io.github.daemonx666.code-speed",
  ]

  caveats <<~EOS
    Code Speed is not notarized yet. If macOS refuses to open it, allow it in
    System Settings → Privacy & Security → Open Anyway, or run
      xattr -dr com.apple.quarantine "#{appdir}/code-speed.app"
  EOS
end
