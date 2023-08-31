# Slow French App

## Technologies:
- iOS 15 and up
- Xcode Version: 14.3.1
- Language: Swift
- Views are written in swiftUI and UIKit.
- Implements the Combine Framework.
- Implements the MVVM architecture.
- Backend: AWS S3, GraphQL API, DynamoDB, Amplify.

## General Info
The Slow French app provides the user with three levels; beginner, intermediate, and advanced French podcasts. Each podcast has a French transcript and an English translation. Also, it allows the user to select the speed of the audio between slow, medium, and fast.

<img width="1848" alt="slowFrench" src="https://github.com/andrearamonroy/AWSGraphQLApi/assets/54419381/9cf2e10b-467f-4c74-bcf0-62839d9eb9f9">

## Backend Development:
The backend is fully hosted on AWS using Swift Amplify. 
To make only one network request it implements GraphQL API.
The audio files are saved in an S3 bucket and the object key is saved in one of two DynamoDB tables (one table with the Podcast info, and one with the Episode info). 

## Architecture:
It implements the Combine Framework and dependecy injection.
It benefits of a network manager and the MVVM architecture. 
Also, the audio files are persisted in order to avoid downloading the audio files every time the view is re-drawn.
