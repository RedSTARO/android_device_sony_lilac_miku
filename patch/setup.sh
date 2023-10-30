# #!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

function green_echo {
  echo -e "${GREEN}$1${NC}"
}

# # green_echo "Plz enter souce code dir: "
# # read -r work_dir

# # if [ ! -d "$work_dir" ]; then
# #   green_echo "SETUP ERROR: dir non-exsits"
# #   exit 1
# # fi

work_dir=/home/r/miku/

green_echo "Entering working dir..."
cd "$work_dir"

green_echo "Replacing 720p boot animation..."
rm -rf vendor/miku/bootanimation/bootanimation.zip
cp device/sony/lilac/patch/bootanimation/bootanimation.zip vendor/miku/bootanimation/bootanimation.zip


green_echo "Updating kernelSU..."
cd "$work_dir/kernel/sony/msm8998"
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
cd "$work_dir"

green_echo "Dropping something rely on LineageOS..."
rm -rf hardware/sony/hidl
rm -rf hardware/sony/amplifier
git apply device/sony/lilac/patch/removeLOSStuff/XperiaParts_Android.bp.patch

green_echo "Removing su stuff in source code..."
rm -rf system/extras/su

green_echo "Apply Udon patches..."
# Set patch stored dir
source_dir="$work_dir/device/sony/lilac/patch/Udon"

# Set mapping of dirs
declare -A target_dirs
target_dirs["bionic"]="$work_dir/bionic"
target_dirs["build_make"]="$work_dir/build/make"
target_dirs["frameworks_base"]="$work_dir/frameworks/base"
target_dirs["frameworks_libs_net"]="$work_dir/frameworks/libs/net"
target_dirs["frameworks_opt_telephony"]="$work_dir/frameworks/opt/telephony"
target_dirs["packages_modules_Connectivity"]="$work_dir/packages/modules/Connectivity"
target_dirs["system_bpf"]="$work_dir/system/bpf"
target_dirs["system_libhidl"]="$work_dir/system/libhidl"
target_dirs["system_netd"]="$work_dir/system/netd"
target_dirs["device_qcom_sepolicy-legacy-um_legacy_vendor_common"]="$work_dir/device/qcom/sepolicy-legacy-um/legacy/vendor/common"

# Apply patches
for dir in "${!target_dirs[@]}"; do
  source_patch_dir="$source_dir/$dir"
  target_patch_dir="${target_dirs[$dir]}"
  if [ -d "$source_patch_dir" ] && [ -d "$target_patch_dir" ]; then
    green_echo "Applying patches in $dir directory..."
    cd "$target_patch_dir"
    for patch_file in "$source_patch_dir"/*.patch; do
      patch -p1 < "$patch_file"
    done
    cd -
  else
    green_echo "Source or target directory not found for $dir, skipping..."
  fi
done
cd $work_dir
green_echo "Patch application complete."

green_echo "Setup finished, now u can start compile ur MikuUI~"