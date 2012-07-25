#!/bin/bash

BUILDDIR=./build
CONTENT=addon.xml\ 720p\ backgrounds\ colors\ fonts\ icon.png\ language\ sounds
     

# Get input
echo "Enter package name:"
read PACKAGENAME
echo "Enter package version:"
read VERSION

echo "Creating package called $PACKAGENAME-$VERSION.zip. Is this correct (Y/n)"
read yesno

case $yesno in
    n|N)
        echo "Stopping."
        exit ;;
    *) ;;
esac

# Cleanup buil dir
rm -fr $BUILDDIR/*
mkdir -p $BUILDDIR/$PACKAGENAME

# Create textures
#make clean -C ./media
make -C ./media
mkdir -p $BUILDDIR/$PACKAGENAME/media
cp ./media/textures.xbt $BUILDDIR/$PACKAGENAME/media/

# Copy files
cp -r $CONTENT $BUILDDIR/$PACKAGENAME/

# Insert version number and addon name
sed -i 's/<!-- versionnum -->/'$VERSION'/g' $BUILDDIR/$PACKAGENAME/addon.xml
sed -i 's/<!-- addonname -->/'$PACKAGENAME'/g' $BUILDDIR/$PACKAGENAME/addon.xml

# Create package
cd $BUILDDIR
zip -q -r ../$PACKAGENAME-$VERSION.zip $PACKAGENAME
cd ..

echo "Done."