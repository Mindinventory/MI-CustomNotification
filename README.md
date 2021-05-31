# MutableCustomNotification

Push notifications allow developers to reach users, even when users aren't actively using an app! With the latest update of iOS Apple provide very useful extensions which are user-friendly. In this tutorial, I am going to share the configuration, set up and testing of Notification with the media attachments like 
Image,
Audio,
Video.

[![name](link to image on GH)](https://ibb.co/TqSVQ1c)

![alt tag](https://ibb.co/TqSVQ1c)
![alt tag](https://ibb.co/TqSVQ1c)
![alt tag](https://ibb.co/TqSVQ1c)


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
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, 
      userInfo: dataDict)
}

## Register the application to get the notification and called it inside the didFinishLaunchingWithOptions

func NotificationConfiguration(_ application: UIApplication){

}
```
## Set Up inside the Notification Service extension
Open the file **NotificationService.swift** and modify the code like below snippet

```python
override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void){

}
```
Use method to download the image from URL and store in local device storage and attched downloaded file to the notification content.

```python
 private func downloadMedia(url: String,_ extensionValue:String, _ identifier:String, handler: @escaping (UNNotificationAttachment?) -> Void) {{

}
```
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
