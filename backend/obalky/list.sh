
for i in 200608 200609 200610 200611 200612 200701 200702 200703 200704 200705 200706 200707 200708 200709 200710 200711 200712 200801 200802 200803 200804 200805 200806 200807 200808 200809 200810 200811 200812 200901 200902 200903 200904 200905 200906 200907 200908 200909 ; do
	echo $i
	wget -O out/$i-toc.html http://toc.nkp.cz/obalkyknih/$i/contents 
	wget -O out/$i-cover.html http://toc.nkp.cz/obalkyknih/$i/covers
done

