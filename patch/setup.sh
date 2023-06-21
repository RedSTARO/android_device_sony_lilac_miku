#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

function green_echo {
  echo -e "${GREEN}$1${NC}"
}

# green_echo "Plz enter souce code dir: "
# read -r work_dir

# if [ ! -d "$work_dir" ]; then
#   green_echo "SETUP ERROR: dir non-exsits"
#   exit 1
# fi

work_dir=/home/r/vdisk/miku/

green_echo "Entering working dir..."
cd "$work_dir"

green_echo "Replacing 720p boot animation..."
rm -rf vendor/miku/bootanimation/bootanimation.zip
cp device/sony/lilac/patch/bootanimation.zip vendor/miku/bootanimation/bootanimation.zip

green_echo "Adding via browser..."
rm -rf packages/apps/via
mkdir packages/apps/via
curl https://res.viayoo.com/v1/via-release-cn.apk > packages/apps/via/via.apk
touch packages/apps/via/Android.mk
git apply device/sony/lilac/patch/handheld_product.mk.patch
git apply device/sony/lilac/patch/via_Android.mk.patch

green_echo "Updating kernelSU..."
cd "$work_dir/kernel/sony/msm8998"
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
cd "$work_dir"

green_echo "Removing internal error hint when power on..."
git apply device/sony/lilac/patch/ActivityTaskManagerService.java.patch

green_echo "Dropping something rely on LineageOS..."
rm -rf hardware/sony/hidl
rm -rf hardware/sony/amplifier
git apply device/sony/lilac/patch/XperiaParts_Android.bp.patch

green_echo "Removing su stuff in source code..."
rm -rf system/extras/su

green_echo "Setup finished, now u can start compile ur MikuUI~"
