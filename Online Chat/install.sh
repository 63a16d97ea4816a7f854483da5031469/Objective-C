#!/usr/bin/env bash
#     __                             ____        _      __      _____ __             __ 
#    / /   ____ ___  _____  _____   / __ \__  __(_)____/ /__   / ___// /_____ ______/ /_
#   / /   / __ `/ / / / _ \/ ___/  / / / / / / / / ___/ //_/   \__ \/ __/ __ `/ ___/ __/
#  / /___/ /_/ / /_/ /  __/ /     / /_/ / /_/ / / /__/ ,<     ___/ / /_/ /_/ / /  / /_  
# /_____/\__,_/\__, /\___/_/      \___\_\__,_/_/\___/_/|_|   /____/\__/\__,_/_/   \__/  
#             /____/                                                                    
#
# This is the Layer Quick Start install script for iOS
#
#    Install the Quick Start project by running this command:
#    curl -L https://raw.githubusercontent.com/layerhq/quick-start-ios/master/install.sh | bash -s "<YOUR_APP_ID>"
#
# Files will be installed in ~/Downloads/ folder.
# 
# This script requires that cocoapods' is already installed.
echo "Welcome to the Layer Quick Start install script for iOS"
echo "This script will:"
echo "1. Download the latest Quick Start project"
echo "2. Inject your app id (if provided)"
echo "3. Grab the latest LayerKit (via cocoapods)"
echo "4. Launch Xcode"

# Check to see if the script is running on OS X

UNAME=$(uname)
if [ "$UNAME" != "Darwin" ] ; then
    echo "Sorry, this OS is not supported."
    exit 1
fi

INSTALL_DIR="$HOME/Downloads/quick-start-ios-master"
mkdir -p "$INSTALL_DIR"

# Download the latest Quick Start project from Github
echo "1: Downloading latest Quick Start project..."
curl -sSL https://github.com/layerhq/quick-start-ios/archive/master.tar.gz | tar -zx -C $HOME/Downloads
echo "QuickStart has been installed in ~/Downloads/quick-start-ios-master."

# Update the generic XCode project with your App ID

if [[ "$1" =~ [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12} ]]; then
	echo "2: Injecting App ID: $1 in the project..."	
	sed -i '' -e "s#LQSLayerAppIDString \= \@\"LAYER_APP_ID\"#LQSLayerAppIDString = \@\"$1\"#" $INSTALL_DIR/QuickStart/LQSAppDelegate.m
else
	echo "2: Skipping App ID injection - No Valid App ID provided."	
fi

# Install the latest LayerKit using Cocoapods

cd $INSTALL_DIR
echo "3: Running 'pod install' to download latest LayerKit via cocoapods (This may take a few minutes)..."
hash pod >/dev/null && /usr/bin/env pod install || {
      echo "You need to install cocoapods to continue: http://cocoapods.org"
      exit 1
}

# Launch XCode

echo "4: Congrats, you're finished! Now opening Xcode. Press CMD-R to run the Project"
open "$INSTALL_DIR/QuickStart.xcworkspace"
open "https://developer.layer.com/docs/quick-start/ios"

