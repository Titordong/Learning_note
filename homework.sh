#!/bin/bash
while true
echo "Please input your score: (0 - 100)"
do
read score
if [ $score -lt 0 ];
then
    break
elif [ $score -lt 60 ];
then
    echo "Failed!"
elif [ $score -lt 70 ];
then
    echo "Passed!"
elif [ $score -lt 80 ];
then
    echo "Medium!"
elif [ $score -lt 90 ];
then
    echo "Good!"
elif [ $score -le 100 ];
then
    echo "Excellent!"
else
    echo "the score must be smaller than 100"
fi
done
exit 0