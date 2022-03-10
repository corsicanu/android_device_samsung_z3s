#!/sbin/sh
# Copyright 2019-2022 © corsicanu
# Licensed under CC BY-NC-SA 4.0
# https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
#
# An extent of original RMM patcher combined with
# Ian Macdonald's Samsung multidisabler, furtherly
# adapted for our specific needs with precious help
# from IvanMeler and AnanJaser1211

# Step 0 - Mount system/vendor and setenforce 0 {just in case}
sleep 5
setenforce 0
mount /system_root
mount -o remount,rw /system_root
mount /vendor
mount -o remount,rw /vendor

# Step 1 - Entirely nuke encryption
for i in /vendor/etc/fstab.exynos*; do
    if [ -f $i ]; then
        sed -i -e 's/^\([^#].*\),fileencryption=[^,]*\(.*\)$/# &\n\1\2/g' $i
    fi
done

# Step 2 - Nuke manifest lines for the given combo of trash services
combo=(vaultkeeper proca wsm)
for service in ${combo[@]}; do
    for i in /vendor/etc/vintf/manifest.xml \
    /vendor/etc/vintf/manifest/vaultkeeper_manifest.xml \
    /vendor/etc/vintf/manifest/wsm_manifest.xml; do
        if [ -f $i ]; then
            sed -i -e '/<hal format="hidl">/{N;/<name>vendor\.samsung\.hardware\.security\.'"$service"'<\/name>/{:loop;N;/<\/hal>/!bloop;d}}' $i
        fi
    done
done

# Step 3 - Nuke trash services inits
for i in $ANDROID_ROOT/system/etc/init/vk*.rc \
    /vendor/etc/init/vk*.rc \
    /vendor/etc/init/vaultkeeper* \
    /vendor/init/cass.rc \
    /vendor/etc/init/cass.rc \
    /vendor/etc/init/pa_daemon*.rc \
    $ANDROID_ROOT/system/bin/vaultkeeperd \
    /vendor/bin/vaultkeeperd; do
    if [ -f $i ]; then
        echo "" > $i
    fi
done

# Step 4 - Others
r=recovery-from-boot.p
for i in $ANDROID_ROOT $ANDROID_ROOT/system /vendor; do
    if [ -f $i/$r ] && [ ! -f $i/$r~ ]; then
      mv $i/$r $i/$r~
    fi
done

# Step 5 - Unmount system/vendor
umount /system_root
umount /vendor

exit 0

