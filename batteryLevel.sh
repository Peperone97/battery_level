#!/bin/bash 

powerLine=`upower -e | grep line`
batterys=`upower -e | grep BAT`
i=1

powerLineStatus=`upower -i $powerLine | grep online`
read -ra isInCharge <<< "$powerLineStatus"

if [ ${isInCharge[1]} = "yes" ]
then
    echo -e "\e[34mThe battery is in charge\e[0m"
else
    echo -e "\e[31mThe battery isn't in charge\e[0m"
fi

for battery in $batterys
do
    #strLength=${#battery}
    #echo $strLength
    #echo Battery $i `upower -i $battery | grep perc`
    level=`upower -i $battery | grep perc`
    read -ra arrayLevel <<< "$level"
    IFS='%' read -ra batteryLevel <<< "${arrayLevel[1]}"
    #echo $batteryLevel
    #echo ${array[1]}
    if [ $batteryLevel -ge 30 ]
    then
	echo -e Battery $i ${arrayLevel[0]} "\e[34m${arrayLevel[1]}\e[0m"
    else
        echo -e Battery $i ${arrayLevel[0]} "\e[31m${arrayLevel[1]}\e[0m"
    fi
    i=`echo $i+1| bc`
done

exit 0
