# MutableCustomNotification

Push notifications allow developers to reach users, even when users aren't actively using an app! With the latest update of iOS Apple provide very useful extensions which are user-friendly. In this tutorial, I am going to share the configuration, set up of Notification with the media attachments like 
* Image
* Audio
* Video

![IMG_9416](https://user-images.githubusercontent.com/84714866/120181588-e4532000-c22a-11eb-88a5-4d2de873694d.PNG)
![IMG_9417](https://user-images.githubusercontent.com/84714866/120181601-eae19780-c22a-11eb-9880-c3684a30a2ac.PNG)
![IMG_9418](https://user-images.githubusercontent.com/84714866/120181603-ec12c480-c22a-11eb-83b1-0311cee247ea.PNG)

## Installation

Install the below pod to your project.

```bash
pod 'Firebase/Core'
pod 'Firebase/Messaging
```
## SetUp

Set up the firebase account and Developer account with require **AppID, certificate, Provisioning profiles, and Googleserivce file.**

## Usage And configure the AppDelagate
import Firebase

Call **FirebaseApp.configure()** in **didFinishLaunchingWithOptions** Method

Inherit the **MessagingDelegate** and its methods

```python
## Call method for getting the token  

func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
   print("Firebase registration token: \(String(describing: fcmToken))")
   let dataDict:[String: String] = ["token": fcmToken ?? ""]
   NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil,userInfo: dataDict)
}

## Register the application to get the notification and called it inside the didFinishLaunchingWithOptions

func NotificationConfiguration(_ application: UIApplication)
{
  if #available(iOS 10.0, *) {
      // For iOS 10 display notification (sent via APNS)
    UNUserNotificationCenter.current().delegate = self
    Messaging.messaging().delegate = self
    Messaging.messaging().isAutoInitEnabled = true
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(
      options: authOptions,
      completionHandler: {_, _ in })
     } else {
     let settings: UIUserNotificationSettings =
     UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
     application.registerUserNotificationSettings(settings)
    }
        
   # DEFINE CATEGRORY ID FOR GEETING AND PROCESSING CUSTOM NOTIFICATION
   let openBoardAction = UNNotificationAction(identifier: UNNotificationDefaultActionIdentifier, title: "Open Board",             options:UNNotificationActionOptions.foreground)                              
   let contentAddedCategory = UNNotificationCategory(identifier: "CATID!", actions: [openBoardAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
   UNUserNotificationCenter.current().setNotificationCategories([contentAddedCategory])
   application.registerForRemoteNotifications()        
}
```
## Set Up NotificationServiceExtension

Add Notification Service extension as per the below screenshot and set up the Notification Service extension inside project

![IMG_9416](https://user-images.githubusercontent.com/84714866/120182723-61cb6000-c22c-11eb-97f3-a78292abc6c3.png)

Open the file **NotificationService.swift** and modify the code like below snippet

**NOTE:** Set up categoryIdentifier is must and it should be same as per the payload and as per the set up which is did in AppDelegate
```python
override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void)
{
       guard let body = bestAttemptContent.userInfo["fcm_options"] as? Dictionary<String, Any>, let imageUrl = body["image"] as? String else { fatalError("Image        Link not found") }
       if(imageUrl.contains(".mp4")){
          downloadMedia(url: imageUrl,".mp4","video") { (attachment) in
              if let attachment = attachment {
                  bestAttemptContent.attachments = [attachment]
                  bestAttemptContent.categoryIdentifier = "CATID!"
                  contentHandler(bestAttemptContent)
              }

          }
      }
}
```
Use method to download the image from URL and store in local device storage and attched downloaded file to the notification content.

```python
 private func downloadMedia(url: String,_ extensionValue:String, _ identifier:String, handler: @escaping (UNNotificationAttachment?) -> Void) {{
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
```
## Note
The same way we can pass the url of Image and Audio with extension and idetifier

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
