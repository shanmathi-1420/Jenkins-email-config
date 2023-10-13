#!/bin/bash
NAME="Shanmathi"
echo "Welcome $NAME! This is a sample bash script file."

for i in {1..5}; do
    echo "Iteration: $i"
done

count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    count=$((count+1))
done

if [ "$NAME" == "John Doe" ]; then
    echo "The name is Shanmathi!"
else
    echo "The name is not Shanmathi!"
fi

