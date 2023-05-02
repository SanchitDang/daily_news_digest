# daily_news_digest

## Features
- Provides authentication through Firebase, allowing users to sign up and log in using their email and password.
- Allows users to log in using their Google or Facebook accounts as well.
- Features a logout button that enables users to log out and switch to a different account.
- Utilizes an API to display the latest trending news on the homepage.
- Includes a search bar to filter news articles by keywords or phrases.
- Implements a local storage feature using shared preferences to save a copy of the latest news. This ensures that the app can still display news articles even when there is no internet connection available.


## Libraries Used
- country_code_picker
\
Used to get different countries with their phone prefix code.
- firebase_auth 
\
Used to signup/login the user.
- firebase_auth 
\
Used to signup/login the user.
- cloud_firestore 
\
Used to save the data of the user after their sign up (name, email, phone).
- flutter_facebook_auth
\
Used to login the user using their FaceBook account.
- http 
\
Used to send and get http requests to get data from API.
\
- shared_preferences 
Used to save the news data locally. So that it can be fetched later if net connection is not available.
\
- connectivity_plus 
Used to check if the internet is available or not, So that if the net is not there then we can show data from our locally saved data.


## Screenshots
Sign Up
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/signup.png" width="200" height="400" />
\
Login
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/login.png" width="200" height="400" />
\
Home
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/home.png" width="200" height="400" />
\
Searching News Using search bar
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/search.png" width="200" height="400" />
\
Data from locally(shared pref) when there is No connection
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/noConnection.png" width="200" height="400" />

## Videos
Sign Up Process
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/signUp.webm" width="200" height="400" />
\
Login Process with Home Screen / News feed and searching
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/login.webm" width="200" height="400" />
\
Home Screen / News feed with No connection
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/noConnection.webm" width="200" height="400" />
\
Login With Gmail
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/gmailLogin.webm" width="200" height="400" />
\
Logout
\
<img src="https://raw.githubusercontent.com/SanchitDang/daily_news_digest/master/WorkingDemo/logout.webm" width="200" height="400" />
\


