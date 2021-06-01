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

## Project SetUp

Drag and Drop the file **UIApplication+CustomNotification** or add the floder **MIAppDelegateExtension** from the project folder and add to your project.

## Modify the AppDelagate

import Firebase

Call **FirebaseApp.configure()** and **NotificationConfiguration(application)** in **didFinishLaunchingWithOptions** Method

```python
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   FirebaseApp.configure()
   NotificationConfiguration(application)
   return true
}
```
## Set Up NotificationServiceExtension

Add Notification Service extension as per the below screenshot and set up the Notification Service extension inside project

![IMG_9416](https://user-images.githubusercontent.com/84714866/120182723-61cb6000-c22c-11eb-97f3-a78292abc6c3.png)

## Notification Service Project SetUp

Drag and Drop the file **MIService** or add the floder **MINotificationServiceExtension** from the Notification Service project folder and add to your project.

## Modify the NotificationService

Inherit NotificationService from the MIService and wrtie down the following method only
```python
override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
  super.didReceive(request, withContentHandler: contentHandler)
}
```
## NOTE

Please verify the **UNNotificationCategory** Identifier in **UIApplication+CustomNotification** file and inside **MIService** file it should be the same like you set in your notification payload.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
