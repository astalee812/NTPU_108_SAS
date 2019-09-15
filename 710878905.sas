/* type2 */
data type2;
input @1 trt @3 mi @5 counts 4.;
cards;
0 1 18
0 2 171
0 3 10845
1 1 5
1 2 99
1 3 10933
;
run;
/* type3 */
data type3;
input trt mi counts @@;
cards;
0118
02171
0310845
115
1299
1310933
run;
/* type6 */
data type6;
input  @1 trt $ @3 mi $3. @6 counts;
cards;
P FA 18 
P NFA 171 
P NA 10845
A FA 5
A NFA 99 
A NA 10933
run;

/* type7 */
data type_7;
input @12 day mmddyy10.;
cards;
 12HELLO  310/21/1946  
4 5GOODBYE611/12/1997
run;

/* type8 */
data type_8;
input @13 day date9.;
cards;
 12HELLO 3  21OCT1946 
4 5GOODBYE6 12NOV1997 
run;