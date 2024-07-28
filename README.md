# function macros

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

## Get Started

```shell
brew install leoafarias/fvm/fvm
fvm use --force

# Add "FVM global" comment to .zshrc if it does not exist
if ! grep -q "FVM global" ~/.zshrc; then
  echo '# FVM global' >> ~/.zshrc
  echo 'export PATH="$PATH":"$HOME/fvm/default/bin"' >> ~/.zshrc
  source ~/.zshrc
fi

brew install jq
FLUTTER_VERSION=$(cat .fvmrc | jq ".flutter" -r)  && \
    fvm global $FLUTTER_VERSION

brew install yq
MELOS_VERSION=$(cat pubspec.lock | yq ".packages.melos.version" -r) && \
    fvm dart pub global activate melos $MELOS_VERSION --overwrite

melos bs
```
