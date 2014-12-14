IMAGES=$(ls -t *.image)
TAGS=()
entry=1
for i in $IMAGES
do
    LABEL=$(echo $i | cut -d'.' -f1)
    TAGS+=($entry "$LABEL")
    entry=$(expr $entry + 1)
done
echo ${TAGS[*]}
choice=$(dialog --menu "Pick an image to run" 40 60 25 "${TAGS[@]}" 2>&1 >/dev/tty)
response=$?
# echo "Choice: $choice"
# echo "RESP:$response"
clear

case $response in
    
    0)
	labelindex=$((($choice-1)*2+1))
	# echo "Labeldex:$labelindex"
	LABEL="${TAGS[$labelindex]}"
	IMAGE="${LABEL}.image"
	# echo "Selected $choice -> ${LABEL}"
	echo "Opening ${IMAGE}"
	./pharo-ui ${IMAGE} &
	;;
    1)
	echo "Cancelled."
	;;

esac
