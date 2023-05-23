
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
Có thể tạo lại thư mục ios(nếu build bằng Xcode bị lỗi):
Xoá thư mục ios:
rm -rf ios
flutter create -i swift .
flutter devices
flutter run -d d7865a14accdaca9abf76a68a73169a04dabeb20

Tuỳ chỉnh cho ios:
https://firebase.flutter.dev/docs/messaging/apple-integration
Key ID: 7ZZCV3PVGV
Team ID: XX74TTBC92

File P8 là một loại tệp chứa khóa riêng tư dạng PEM được sử dụng bởi Apple 
để cung cấp quyền truy cập tới một số dịch vụ, như chẳng hạn Apple Push Notification service (APNs).
File P8 cụ thể được sử dụng để tạo và xác thực mã thông báo (tokens) mà ứng dụng của bạn 
sẽ sử dụng để kết nối với APNs.



