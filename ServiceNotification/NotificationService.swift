//
//  NotificationService.swift
//  Service
//
//  Created by Debashish Das on 29/09/20.
//  Copyright © 2020 Debashish Das. All rights reserved.
//

import UserNotifications
class NotificationService: MIService {
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        super.didReceive(request, withContentHandler: contentHandler)
    }
}
