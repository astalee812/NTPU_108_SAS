/*seat-belt 0 = NO, seat-belt 1 = Yes, injury 0 = Fatal, injury 1 = nonfatal*/
data data1;
input seat_belt injury count;
cards;
0 0 1085
0 1 55623
1 0 703
1 1 441239
run;
proc freq data=data1;
weight count;
table seat_belt*injury /relrisk;
run;
proc freq data=data1;
weight count;
table seat_belt*injury /chisq expected measures;
run;
/* 2 */
/* drug1=drug, drug2=no_drug */
/*  */
data data2;
input diagnosis drug count;
cards;
1  1 105
1  2 8
2 1 12
2 2 2
3 1 18
3 2 19
4 1 47
4 2 52
5 1 0
5 2 13
run;
proc freq data=data2;
where diagnosis in (1,2);
weight count;
tables diagnosis*drug/chisq measures;
run;
proc freq data=data2;
where diagnosis in (3,4);
weight count;
tables diagnosis*drug/chisq measures;
run;
proc format;
value diagfmt 1-2="1+2" 3-4="3+4" 5="5";
;
proc freq data=data2;
weight count;
tables diagnosis*drug/chisq expected measures;
format diagnosis diagfmt.;
run;

/* 3 */
/* income low = 1, income middle = 2, income hight = 3 */
/* high school = 1, hight school graduate = 2, college = 3, college graduate = 4*/
data data3;
input school income count;
cards;
1 1 9
1 2 11
1 3 9
2 1 44
2 2 52
2 3 41
3 1 13
3 2 23
3 3 12
4 1 10
4 2 22
4 3 27
run;
proc freq data=data3;
weight count;
tables school*income / chisq expected measures cmh1;
proc genmod data=data3;
model count=school income / residuals;
run;
