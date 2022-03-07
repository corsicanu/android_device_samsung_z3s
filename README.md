# TWRP device tree for Samsung S20+ aka y2s

## Kernel source 
Available at https://github.com/corsicanu/android_kernel_samsung_universal9830

## How to build
This was tested and it's fully compatible with [minimal manifest twrp](https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp).
1. Set up the build environment following instructions from [here](https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp/blob/twrp-11/README.md#getting-started)
2. In the root folder of cloned repo you need to clone the device tree:
```bash
git clone -b android-11.0 https://github.com/corsicanu/android_device_samsung_y2s.git device/samsung/y2s
```
3. To build:
```bash
export ALLOW_MISSING_DEPENDENCIES=true && . build/envsetup.sh && lunch twrp_y2s-eng && mka recoveryimage -j128
```

