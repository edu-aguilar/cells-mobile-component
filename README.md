# cells-mobile-component
a script to run a cells component in mobile

This script adapts your component demo to a cordova based project. The main goal is run your component in mobile.

#### PRERREQUISITES.
- mobile sdk(android, ios or whatever you want to run) and updated dependecies.
- cordova (npm install -g cordova).
- developer mode enabled in your phone.

#### ENVIRONMENT
- mac os terminal
- cells:component folder

#### COMMAND OPTIONS
- -f || -full             --> after build, the process will run the component in mobile. (default platform "android")
- -f || -full [platform]  --> after build, the process will run the component in selected platform (ios, android, browser)

#### EXAMPLES
- sh -e element-app.sh -f ios
- sh -e element-app.sh -full
