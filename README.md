# email-client
Email client for the email WS

##Getting Started
1. clone the repo
2. cd to the folder and run `pod install` (if you don't have cocoapods installed, then google how to install them on a mac)
3. open the file SampleEmailApp.xcworkspace in XCode
4. select a simulator (tested on iPhone 7) and run the code (you may need to select your development profile as the code signing identity)

Rest of the app is quite simple and should be mostly self-explanatory. Some of the features that the email-ws web server supports are not yet supported in the iOS client here.

For logging out as a user, just kill and relaunch the app to enter new credentials.

Available users, their names and passwords are :
{ "userEmail" : “johnsnow@gmail.com", "userName" : “John Snow", "userPassword" : “johnxxx” }
{ "userEmail" : "nedstark@gmail.com", "userName" : "Ned Stark", "userPassword" : "honorxxx” }
{ "userEmail" : "nightking@gmail.com", "userName" : "Night King", "userPassword" : "winterxxx” }
{ "userEmail" : "khaleesi@gmail.com", "userName" : "Danaerys Targaryen", "userPassword" : "dracarys” }
{ "userEmail" : "cersei@gmail.com", "userName" : "Cersei Lannister", "userPassword" : "queen” }

On login, the page may show empty. Please pull down to refresh and fetch data from server. Same has to be done after sending any emails, so that those show up in your email list.

