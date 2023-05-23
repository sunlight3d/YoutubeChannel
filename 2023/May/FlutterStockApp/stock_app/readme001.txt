
Sửa file path:
export PATH="$PATH":"$HOME/.pub-cache/bin"
source ~/.zshrc

Cài Firebase CLI:
https://firebase.google.com/docs/cli#mac-linux-auto-script

Làm theo hướng dẫn:
https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins

firebase login
dart pub global activate flutterfire_cli
flutterfire configure
flutter pub add firebase_core
flutterfire configure

Thêm plugins:
flutter pub add firebase_analytics
flutter pub add firebase_messaging
flutter pub add firebase_database
flutter run

Theo hướng dẫn
https://firebase.flutter.dev/docs/messaging/overview

Xem them:
https://pub.dev/packages/firebase_messaging/example

Chạy app, lấy FCM token
Vào FCM Dashboard(Engage -> messaging):
https://console.firebase.google.com/project/stockapp-b0883/messaging/onboarding
Gửi thử FCM, dùng FCM token ở trên

Tuỳ chỉnh cho ios:
Xcode, Targets: Runner, Capability, tìm kiếm "Push Notification"
Xcode, Targets: Runner, Capability, Tìm kiếm "Background Modes"
Checkbox vào Background fetch, Remote notifications
https://firebase.flutter.dev/docs/messaging/apple-integration





