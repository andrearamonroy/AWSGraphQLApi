# Slow French App

##Technologies:
- iOS 15 and up
- Xcode Version: 14.3.1
- Language: Swift
- Views are written in swiftUI and UIKit.
- Implements the Combine Framework.
- Implements the MVVM architecture.
- Backend: AWS S3, GraphQL API, DynamoDB, Amplify.

##General Ingo
The Slow French app provides the user with three levels beginner, intermidiate, and advance French podcasts. Each podcast has a French transcript and English tranlastion. Also, it allows the user to select the speed of the audio between slow, medium, and fast.

<img width="1848" alt="slowFrench" src="https://github.com/andrearamonroy/AWSGraphQLApi/assets/54419381/9cf2e10b-467f-4c74-bcf0-62839d9eb9f9">

##Development Details:
The backend is fully hosted on AWS using Swift Amplify to make the network call. 
It implements GraphQL API to make only one network request. 
The audio files are saved in an S3 bucket and the object key is saved in one of two DynamoDB tables (one table with the Podcast info, and one with the Episode info). 

##Architecture:
It implements the Combine Framework and dependecy injection.
It benefits of a network manager and the MVVM architecture. 
Also, the audio files are persisted in order to not download the audio files every time the view is re-drawn.
