cask "localvoxtral" do
  version "0.15.0"
  sha256 "e9bd7c86aa20121fe68c921b6082bf5e1ad1bbdfdf7e6f96f4451c66270d4c65"

  url "https://github.com/T0mSIlver/localvoxtral/releases/download/v#{version}/localvoxtral-v#{version}.zip"
  name "localvoxtral"
  desc "Realtime dictation from the menu bar"
  homepage "https://github.com/T0mSIlver/localvoxtral"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "localvoxtral.app"

  uninstall quit: "com.localvoxtral.app"

  # Dictation history lives in the app's folder (history.store). Builds before
  # #985 kept it in ~/Library/Application Support/default.store, a name other
  # apps share, so zap leaves that file. Downloaded models in
  # ~/.cache/huggingface are shared too.
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

    Releases before October 2026 were ad-hoc signed. After upgrading from
    one, macOS asks for Accessibility again, once: if the dictation shortcut
    does nothing, remove localvoxtral from System Settings > Privacy &
    Security > Accessibility (Device Control and Data Access on macOS 27) and
    add it back.
  EOS
end
