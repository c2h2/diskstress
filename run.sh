#!/bin/bash

date

SIZE=128


cycle(){
	i=$1
	echo "Creating ${SIZE}MB random dummy file ${i}"
	dd if=/dev/urandom of=dummy_rand${i}.bin.test bs=1M count=$SIZE >/dev/null 2>/dev/null
	md5_1=`md5sum dummy_rand${i}.bin.test | awk '{print $1}'`

	echo "Verify with copy..."
	cp dummy_rand${i}.bin.test copy_dummy_rand${i}.bin.test >/dev/null 2>/dev/null
	md5_2=`md5sum copy_dummy_rand${i}.bin.test | awk '{print $1}'`

	if [ "$md5_1" == "$md5_2" ]; then
		echo "GOOD: md5s match ${md5_1}"
	else
		echo "ERROR!!!! md5s mismatch"
		exit 1
	fi

	#echo "Creating ${SIZE}MB zero file ${i}"
	#dd if=/dev/urandom of=dummy_zero${i}.bin.test bs=1M count=$SIZE >/dev/null 2>/dev/null
       	#md5sum dummy_zero${i}.bin.test >/dev/null 2>/dev/null
}
for j in {1..100}; do
	echo "$j big loop."
	for i in {1..200}; do
		cycle ${i}
	done
done
