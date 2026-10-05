cask "localvoxtral" do
  version "0.13.0"
  sha256 "7ee353424ad5cebda7fe373dd1dff6ed4e1dd8d611fac31fc6296e514a2ded7a"

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
