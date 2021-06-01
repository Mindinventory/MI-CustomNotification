//
//  NotificationService.swift
//  Service
//
//  Created by Debashish Das on 29/09/20.
//  Copyright © 2020 Debashish Das. All rights reserved.
//

import UserNotifications
import CoreData
import UIKit
import AVFoundation

open class MIService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    //MARK: METHOD THAT CALLED WHEN NOTIFICATION ARRIVE
    open override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void)
    {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            
            //MARK: USED BELOW METHOD WHEN NOTIFICATION ARRIVE SAVE DATA TO DEFAULT
            if let defaults = UserDefaults(suiteName: "group.com.temp.notificationrich") {
                if let aps = bestAttemptContent.userInfo["aps"] as? [String: Any] {
                    if let data = self.getNotification(userInfo: aps) {
                        defaults.set("TITLE : \(data.0) + BODY : \(data.1)", forKey: "notification")
                    }
                }
            }
            
            //---------------------------------------
            
            //MARK: USED BELOW METHOD WHEN NOTIFICATION ARRIVE SAVE DATA TO COREDATA
            if let aps = bestAttemptContent.userInfo["aps"] as? [String: Any] {
                if self.getNotification(userInfo: aps) != nil {
                }
            }
            
            //---------------------------------------
            
            
            //MARK: MODIFY NOTIFICATION CONTENT WHEN NOTIFICATION ARRIVE
            
            guard let body = bestAttemptContent.userInfo["fcm_options"] as? Dictionary<String, Any>, var imageUrl = body["image"] as? String else { fatalError("Image Link not found") }
           imageUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
             if(imageUrl.contains(".mp4") || imageUrl.contains(".mov") || imageUrl.contains(".avi")){
                downloadMedia(url: imageUrl,".mp4","video") { (attachment) in
                    if let attachment = attachment {
                        bestAttemptContent.attachments = [attachment]
                        bestAttemptContent.categoryIdentifier = "CATID!"
                        contentHandler(bestAttemptContent)
                    }

                }
            }
            //MARK: PROCEED AUDIO URL WHICH WILL COME IN THE MUTABLE CONTENT PAYLOAD WITH THE USE OF REGISTER CATEGORY ID
            
            if(imageUrl.contains(".mp3")){
                downloadMedia(url: imageUrl,".mp3","Audio") { (attachment) in
                    if let attachment = attachment {
                        bestAttemptContent.attachments = [attachment]
                        bestAttemptContent.categoryIdentifier = "CATID!"
                        contentHandler(bestAttemptContent)
                    }
                }
            }
            //MARK: PROCEED IMAGE URL WHICH WILL COME IN THE MUTABLE CONTENT PAYLOAD WITH THE USE OF REGISTER CATEGORY ID
            
            if(imageUrl.contains(".png") || imageUrl.contains(".PNG") || imageUrl.contains(".jpg") || imageUrl.contains(".jpeg")){
                downloadMedia(url: imageUrl,".jpg","picture") { (attachment) in
                    if let attachment = attachment {
                        bestAttemptContent.attachments = [attachment]
                        bestAttemptContent.categoryIdentifier = "CATID!"
                        contentHandler(bestAttemptContent)
                    }
                }
            }
        
        }
    }
    
    //MARK: - PARSE THE NOTIFICATION TEXT AND BODY DATA

    private func getNotification(userInfo: [String: Any]) -> (String, String)? {
        guard let notification = userInfo["alert"] as? [String: Any] else { return nil }
        if let title = notification["title"] as? String, let body = notification["body"] as? String {
            return (title, body)
        }
        return nil
    }
    func extractYoutubeIdFromLink(link: String) -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
        return nil
        }
        let nsLink = link as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0, length: nsLink.length)
        let matches = regExp.matches(in: link as String, options:options, range:range)
        if let firstMatch = matches.first {
        return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }
    //MARK: - DOWNLOAD RESOURCE LIKE AUDIO,VIDEO OR IMAGE FROM THE PAYLOAD URL

    private func downloadMedia(url: String,_ extensionValue:String, _ identifier:String, handler: @escaping (UNNotificationAttachment?) -> Void) {
        let task = URLSession.shared.downloadTask(with: URL(string: url)!) { (downloadedUrl, response, error) in
            guard let downloadedUrl = downloadedUrl else { handler(nil) ; return }
            var urlPath = URL(fileURLWithPath: NSTemporaryDirectory())
            let uniqueUrlEnding = ProcessInfo.processInfo.globallyUniqueString + extensionValue
            urlPath = urlPath.appendingPathComponent(uniqueUrlEnding)
            try? FileManager.default.moveItem(at: downloadedUrl, to: urlPath)
            do {
                let attachment = try UNNotificationAttachment(identifier: identifier, url: urlPath, options: nil)
                handler(attachment)
            } catch {
                print("attachment error")
                handler(nil)
            }
        }
        task.resume()
    }
    public override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}

