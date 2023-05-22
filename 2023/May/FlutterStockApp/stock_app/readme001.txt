Đối với Android, bạn cần tải xuống tệp google-services.json từ Firebase Console 
và paste vào thư mục android/app trong dự án Flutter
Đối với iOS là ios/Runner/GoogleService-Info.plist.

flutter pub add firebase_messaging
flutter pub add firebase_core
dart pub global activate flutterfire_cli

Sửa file path:
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutterfire configure

firebase logout
firebase login
flutterfire configure
Chọn project vừa tạo, chọn ios, android, web
flutterfire sẽ tự động update lên firebase Console




Trong tệp ios/Runner.xcodeproj/project.pbxproj, 
tìm dòng chứa PRODUCT_BUNDLE_IDENTIFIER. 
Giá trị sau dấu bằng (=) chính là Apple Bundle ID.

Trong tệp android/app/build.gradle, tìm dòng chứa applicationId. 
Giá trị sau dấu bằng (=) chính là Android Package Name

Sửa 2 file build.gradle trong ứng dụng Android: thêm google services, firebase bom

Config local push notification ở đây:
https://pub.dev/packages/flutter_local_notifications

coreLibraryDesugaringEnabled true
Desugaring là một quá trình biên dịch và chuyển đổi 
mã nguồn Java mới thành mã nguồn Java cũ tương thích với các phiên bản 
Android cũ hơn (trước Android 8.0).

Bên ios, sửa cả Podfile, Info.plist, thêm 

Vào FCM Dashboard(Engage -> messaging):
https://console.firebase.google.com/project/stockapp-b0883/messaging/onboarding

