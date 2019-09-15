data type_3;
input trt 1 mi 2 counts 3-7;
cards;
0118
02171
0310845
115
1299
1310933
run;

data type_7;
input @12 day mmddyy10.;
cards;
 12HELLO  310/21/1946  
4 5GOODBYE611/12/1997
run;

data type_8;
input @12 day date9.;
cards;
 12HELLO  3 21OCT1946 
4 5GOODBYE6 12NOV1997  
run;