#!/bin/bash

# # 提示用户输入目录
# echo "请输入工作目录："
# read -r work_dir

# # 检查目录是否存在
# if [ ! -d "$work_dir" ]; then
#   echo "错误：目录不存在。"
#   exit 1
# fi
work_dir=/home/r/vdisk/miku/


echo "Entering working dir..."
cd $work_dir

echo "Replacing 720p boot animation..."
rm -rf vendor/miku/bootanimation/bootanimation.zip
cp device/sony/lilac/patch/bootanimation.zip vendor/miku/bootanimation/bootanimation.zip

echo "Adding via browser..."
rm -rf packages/apps/via
mkdir packages/apps/via
curl https://res.viayoo.com/v1/via-release-cn.apk > packages/apps/via/via.apk
touch packages/apps/via/Android.mk
git apply device/sony/lilac/patch/handheld_product.mk.patch
git apply device/sony/lilac/patch/via_Android.mk.patch

echo "Updating kernelSU..."
cd $work_dir/kernel/sony/msm8998
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
cd $work_dir

echo "Removing su stuff in source code..."
