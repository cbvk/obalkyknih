
for m in 200902 200903 200904 200905 200906 200907 200908 200909 ; do
	echo $m
	./bin/crawler.pl period ${m}01 ${m}28 >toc/$m.txt 2>toc/$m.err
done

