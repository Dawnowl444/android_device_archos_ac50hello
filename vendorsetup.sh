DEVICE=ac50hello

if [[ -f android/omni-aosp.xml ]]; then
	distribution='omni'
elif [[ -d lineage-sdk ]]; then
	distribution='lineage'
else
	distribution='full'
fi

for buildtype in eng user userdebug; do
	add_lunch_combo ${distribution}_${DEVICE}-${buildtype}
done 