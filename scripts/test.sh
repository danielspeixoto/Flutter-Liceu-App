#!/usr/bin/env bash
set -e
set -x

echo "ENV=staging
FACEBOOK_TOKEN=$(dart scripts/facebookToken.dart)
URL=https://liceu-staging.herokuapp.com/v2
API_KEY=2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy
" > .env
adb uninstall com.deffish
flutter drive --target=test_driver/app.dart
