# FirstChat: Incognito Chat

## Introduction

<b>Getting bored? Worry not! Here's FirstChat!</b>

A beautiful messaging app where you can interact with anonymous people in an anonymous group while being anonymous ;)
If you are getting bored and want to talk to strangers without revealing your identity, you can register on the app
where you can chat in an anonymous group. The app is written in Flutter, a hybrid mobile app framework, and uses
Firebase Authentication and Firestore services for user authentication and messaging over the internet. The app has a
beautiful UI that promotes user interaction and provides a good user experience.

## Preview

<img height="500" src="https://github.com/srockstech/first_chat/blob/main/images/preview.gif">

## APK

Download APK from releases section

## Tech Stack Used

- Dart-lang
- Flutter
- Firebase Firestore
- Firebase Authentication

## Flutter Packages/dependencies

- firebase_core
- firebase_auth
- cloud_firestore
- modal_progress_hud
- font_awesome_flutter
- cupertino_icons

## My takeaways and learnings

I learned about the concept of polling, which is heavily used while developing real-world mobile and web applications.
Polling is implemented using streams, and by subscribing to these streams, the client application gets notified of the
new data as soon as it comes to an API or a database. I used this to display the messages as soon as they were sent from
the client and stored in the Firebase Firestore database. This helped me integrate real-time messaging into the app.
Furthermore, I learned about Backend-as-a-Service (BaaS) and Google Cloud Platform's BaaS offering named Firebase.