: '
  This script adapts your component demo to a cordova based project. The main goal is run your component in mobile.

  PRERREQUISITES.
    mobile sdk(android, ios or whatever you want to run) and updated dependecies.
    cordova (npm install -g cordova).
    developer mode enabled in your phone.

  ENVIRONMENT
    mac os terminal
    cells:component folder

  COMMAND OPTIONS
    -f || -full             --> after build, the process will run the component in mobile. (default platform "android")
    -f || -full [platform]  --> after build, the process will run the component in selected platform

  EXAMPLES
    sh -e element-app.sh -f ios
    sh -e element-app.sh -full
'

#functions
get_component_name () {
  location=$(pwd)
  IFS=/
  pwd_arr=($location)
  length=${#pwd_arr[@]}
  last_pos=$(( $length - 1 ))
  comp_name=${pwd_arr[$last_pos]}
  echo $comp_name
}
get_clean_component_name () {
  comp_name=$(get_component_name)
  char=''
  echo ${comp_name//[-]/$char}
}
# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_RED=$ESC_SEQ"31;01m"


#cleaning and set up the process
rm -rf demo-app
comp_name=$(get_component_name)
clean_comp_name=$(get_clean_component_name)


#1- creating cordova app
echo step 1 - creating cordova app
cordova create demo-app com.cellsComponent.$clean_comp_name $comp_name


#2- replacing www folder with demo content
echo step 2 - initializing cordova project
rm -rf demo-app/www
cp -R demo demo-app/www


#3- replace all dependecies from index.html
echo step 3 - moving dependencies to cordova app
cp -R bower_components demo-app/www


#4- replace all dependecies from index.html
echo step 4 - replacing dependencies routes
sed -i -e 's,../../,bower_components/,g' demo-app/www/index.html


#5- create and move own component to new folder
echo step 6 - moving component to our cordova app
mkdir demo-app/www/$comp_name/
cp $comp_name.html $comp_name.js $comp_name-styles.html demo-app/www/$comp_name/


#6- linking to our component from demo index.html
echo step 7 - replacing dependencies routes II
sed -i -e 's,\../,'$comp_name'/,g' demo-app/www/index.html


#7- linking the dependencies from our component
echo step 8 - replacing dependencies routes from our component
sed -i -e 's,\../,\../bower_components/,g' demo-app/www/$comp_name/$comp_name.html


case $1 in
   --full | -f)
      platform=$2
      if [ -z "$2" ]
        then
          echo "$COL_RED u didnt set platform, default is android $COL_RESET"
          platform=android
      fi
      cd demo-app && cordova platform add $platform && cordova run $platform
      ;;
   *)
      echo "\n\t $COL_BLUE ***************$COL_MAGENTA PROCESS DONE $COL_BLUE***************\n"
      echo "\t $COL_MAGENTA Now you can go to demo-app/ and type:"
      echo "\t  cordova platform add [android | ios | browser]"
      echo "\t  cordova run [android | ios | browser] $COL_RESET"
      ;;
esac
