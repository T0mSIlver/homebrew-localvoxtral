cask "localvoxtral" do
  version "0.9.0"
  sha256 "ea961909a240fc7418dfea2eabee519a94b61efbcb1d62ab636e6e872c874df0"

  url "https://github.com/T0mSIlver/localvoxtral/releases/download/v#{version}/localvoxtral-v#{version}.zip"
  name "localvoxtral"
  desc "Realtime dictation from the menu bar"
  homepage "https://github.com/T0mSIlver/localvoxtral"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "localvoxtral.app"

  # Releases are ad-hoc signed and not notarized. On macOS 26 Gatekeeper's
  # first-exec scan can hang forever on a downloaded foreign ad-hoc signature,
  # and clearing quarantine alone does not fix it; a local re-sign does.
  # scripts/install.sh does the same two things for the same reason.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/localvoxtral.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/localvoxtral.app"]
  end

  uninstall quit: "com.localvoxtral.app"

  # Dictation history is not listed: it lives in SwiftData's default store,
  # ~/Library/Application Support/default.store, a name other apps can share.
  # Downloaded models in ~/.cache/huggingface are shared too.
  zap trash: [
    "~/Library/Application Support/localvoxtral",
    "~/Library/Caches/com.localvoxtral.app",
    "~/Library/HTTPStorages/com.localvoxtral.app",
    "~/Library/Preferences/com.localvoxtral.app.plist",
    "~/Library/Saved Application State/com.localvoxtral.app.savedState",
  ]

  caveats <<~EOS
    On first launch a setup wizard asks for the microphone and Accessibility
    permissions, then for an engine: local models (downloaded once) or
    Mistral's hosted API (paste a key, nothing to download).

    Releases are ad-hoc signed, so macOS may drop the Accessibility grant
    after an upgrade. If the dictation shortcut stops working, toggle
    localvoxtral off and on in System Settings > Privacy & Security >
    Accessibility.
  EOS
end
