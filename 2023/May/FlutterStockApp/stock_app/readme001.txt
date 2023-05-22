Đối với Android, bạn cần tải xuống tệp google-services.json từ Firebase Console 
và paste vào thư mục android/app trong dự án Flutter
Đối với iOS là ios/Runner/GoogleService-Info.plist.

Trong tệp ios/Runner.xcodeproj/project.pbxproj, 
tìm dòng chứa PRODUCT_BUNDLE_IDENTIFIER. 
Giá trị sau dấu bằng (=) chính là Apple Bundle ID.

Trong tệp android/app/build.gradle, tìm dòng chứa applicationId. 
Giá trị sau dấu bằng (=) chính là Android Package Name

Sửa 2 file build.gradle trong ứng dụng Android: thêm google services, firebase bom
