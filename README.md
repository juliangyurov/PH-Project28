## [Project 28: Secret Swift](https://www.hackingwithswift.com/read/28/overview)
Written by [Paul Hudson](https://www.hackingwithswift.com/about)  ![twitter16](https://github.com/juliangyurov/PH-Project6a/assets/13259596/445c8ea0-65c4-4dba-8e1f-3f2750f0ef51)
  [@twostraws](https://twitter.com/twostraws)

**Description:** Save user data securely using the device keychain and Touch ID.

- Setting up

- Creating a basic text editor

- Writing somewhere safe: the iOS keychain

- Touch to activate: Touch ID, Face ID and `LocalAuthentication`

- Wrap up
  
## [Review what you learned](https://www.hackingwithswift.com/review/hws/project-28-secret-swift)

**Challenge**

1. Add a Done button as a navigation bar item that causes the app to re-lock immediately rather than waiting for the user to quit. This should only be shown when the app is unlocked.

2. Create a password system for your app so that the Touch ID/Face ID fallback is more useful. You'll need to use an alert controller with a text field like we did in project 5, and I suggest you save the password in the keychain!

3. Go back to Project10 (Names to Faces) and add biometric authentication so the user’s pictures are shown only when they have unlocked the app. You’ll need to give some thought to how you can hide the pictures – perhaps leave the array empty until they are authenticated?
