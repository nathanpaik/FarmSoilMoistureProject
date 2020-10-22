# FarmSoilMoisture
For work on the "Climate Change in a Hungry World" citizen science project

## App

   Flutter

## Web Interface

  React.js

## Database

  MongoDB
  

node.js for testing and packaging

# static pages folder
- bootstrap used for easy design and future customization if need arises
- landing page, sign up and log in design added
- authentication included in app.js
### issues
- for design's sake, map needs to be out of container
- general website appearance, especially the data visualization
- Should add email messagefield?
- Do we need a navbar for the landing page?

# App.js and other server-side programs
### dependecies
- **dotenv** - manages environment variables to keep them secure when commiting files to remote git repos.
The environment variables may contain sensitive information such as API keys etc.
It is important that we require the module as early as possible (preferably at the very start of the app.js file) to allow it to configure 
  all the environment variables. Any environment variable declared before the module is not configured.

### authentication and login
- The bcrypt library has been used to hash user passwords, with 10 rounds of salting to enhance encryption.
- For login activity:
> after a successful login, a session is maintained and established through a cookie set in the user's browser so that each subsequent does not contain credentials, but rather a unique cookie that identifies the session.
> Passport.js is used to serialize and deserialize the `User` instances to and from the sessions

