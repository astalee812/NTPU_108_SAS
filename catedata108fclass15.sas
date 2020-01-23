data class15d1;
do g='M','F';
	do i='S', 'O';
		do h='S','O';
			input count @@;
			output;
		end;
	end;
end;
cards;
76 160 6 25
114 181 11 48
run;
