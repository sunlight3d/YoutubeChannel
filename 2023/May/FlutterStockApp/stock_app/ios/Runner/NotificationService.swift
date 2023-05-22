//
//  NotificationService.swift
//  Runner
//
//  Created by Nguyen Duc Hoang on 22/05/2023.
//
import Foundation
import FirebaseMessaging
import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        if let bestAttemptContent = bestAttemptContent {
            // Xử lý thông báo tại đây
            let content = UNMutableNotificationContent()
            content.title = "Notification Title"
            content.body = "Notification Body"

            let request = UNNotificationRequest(identifier: "notification_1", content: content, trigger: nil)

            let center = UNUserNotificationCenter.current()
            center.add(request) { (error) in
                if let error = error {
                    print("Error adding notification request: \(error.localizedDescription)")
                }
            }
            contentHandler(bestAttemptContent)
        }
    }

    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            // Gọi lại contentHandler nếu thời gian mở rộng dịch vụ hết hạn
            contentHandler(bestAttemptContent)
        }
    }
}
