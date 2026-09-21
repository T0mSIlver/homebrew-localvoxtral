# homebrew-localvoxtral

Homebrew tap for [localvoxtral](https://github.com/T0mSIlver/localvoxtral),
realtime dictation for the macOS menu bar.

```bash
brew install --cask T0mSIlver/localvoxtral/localvoxtral
```

Requires an Apple Silicon Mac on macOS 15 or later. `brew upgrade` follows
stable releases; nightlies are installed with the
[installer script](https://github.com/T0mSIlver/localvoxtral/blob/main/docs/install.md#nightly-channel).

`Casks/localvoxtral.rb` is generated. localvoxtral's release pipeline rewrites
it after each stable release, so changes to the cask go to
[`scripts/ci/render-cask.sh`](https://github.com/T0mSIlver/localvoxtral/blob/main/scripts/ci/render-cask.sh)
in the main repository, and issues go
[there](https://github.com/T0mSIlver/localvoxtral/issues) too.

The cask was first written by [@achembarpu](https://github.com/achembarpu).
