#!/bin/sh
CWD=$(pwd)
PACKAGES_RELATIVE_PATH="packages"
PACKAGES_DIR="$CWD/$PACKAGES_RELATIVE_PATH"

fvm flutter packages pub run build_runner build --delete-conflicting-outputs

excludedPackages=("linter_rules")

for package_name in $(ls $PACKAGES_DIR); do
    if [[ ! " ${excludedPackages[*]} " =~ " ${package_name} " ]]; then
         PACKAGE_DIR="$PACKAGES_DIR/$package_name"
         echo "Entering $PACKAGES_RELATIVE_PATH/$package_name"
         cd $PACKAGE_DIR && fvm flutter packages pub run build_runner build --delete-conflicting-outputs
    fi
done
