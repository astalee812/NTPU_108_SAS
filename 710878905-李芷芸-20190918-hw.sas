/*ch1d2*/
data ds2;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d2.txt";
input aa$ age gender$ bb$ cc$ dd ee;
run;
proc print data =  ds2;
run;
/*ch1d3*/
data ds3;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d3.txt";
input aa$ bb$ cc$;
run;
/*ch1d4*/
data ds4;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d4.dat";
input aa$ bb$ cc$ dd$ ee$ ff$ gg$ hh$ ii$ jj$ kk$14.;
run;
proc print data =  ds4;
run;
/*ch1d5*/
data ds5;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d5.dat" delimiter=",";
input id $ grade1 grade2 grade3 grade4;
run;
proc print data =  ds5;
run;
/*ch1d6*/
data ch1d6;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d6.txt" firstobs=40; 
input  FTP UEMP MAN LIC GR CLEAR WM NMAN GOV HE WE HOM ACC ASR @@;
run;
proc print; run;