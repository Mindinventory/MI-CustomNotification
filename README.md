# MI-Notification

Push notifications allow developers to reach users, even when users aren't actively using an app! With the latest update of iOS Apple provide very useful extensions which are user-friendly. In this tutorial, I am going to share the configuration, set up of Notification with the media attachments like. Read more from [MEDIUM](https://medium.com/mindful-engineering/notification-customization-446a7ffde8c2)
* Image
* Audio
* Video

![IMG_9422 2](https://user-images.githubusercontent.com/84714866/120331004-f906e500-c30a-11eb-8294-436b4ee26d3c.PNG)
![IMG_9422](https://user-images.githubusercontent.com/84714866/120331023-fe642f80-c30a-11eb-87cb-e3ecf88de3b2.PNG)
![IMG_9423 3](https://user-images.githubusercontent.com/84714866/120331027-fefcc600-c30a-11eb-8a4c-9cdb3ac78f92.PNG)

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

**Please take care of the bundle id of Notification Service project it should be compulsory prefix with the main project bundle ID. See the demo project's both bundle id main project and Notification Service project BundleId**


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
MI-Notificaion is [MIT-licensed](/LICENSE).
