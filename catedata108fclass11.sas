data ch5d2;
      length Response $12;
      input Volume Rate Response @@;
      LogVolume=log(Volume);
      LogRate=log(Rate);
      datalines;
   3.70  0.825  constrict       3.50  1.09   constrict
   1.25  2.50   constrict       0.75  1.50   constrict
   0.80  3.20   constrict       0.70  3.50   constrict
   0.60  0.75   no_constrict    1.10  1.70   no_constrict
   0.90  0.75   no_constrict    0.90  0.45   no_constrict
   0.80  0.57   no_constrict    0.55  2.75   no_constrict
   0.60  3.00   no_constrict    1.40  2.33   constrict
   0.75  3.75   constrict       2.30  1.64   constrict
   3.20  1.60   constrict       0.85  1.415  constrict
   1.70  1.06   no_constrict    1.80  1.80   constrict
   0.40  2.00   no_constrict    0.95  1.36   no_constrict
   1.35  1.35   no_constrict    1.50  1.36   no_constrict
   1.60  1.78   constrict       0.60  1.50   no_constrict
   1.80  1.50   constrict       0.95  1.90   no_constrict
   1.90  0.95   constrict       1.60  0.40   no_constrict
   2.70  0.75   constrict       2.35  0.03   no_constrict
   1.10  1.83   no_constrict    1.10  2.20   constrict
   1.20  2.00   constrict       0.80  3.33   constrict
   0.95  1.90   no_constrict    0.75  1.90   no_constrict
   1.30  1.625  constrict
   ;
proc logistic data=ch5d2 
	plots(only label)=(phat leverage dpc);
      model Response=LogRate LogVolume;
run;
/* dpb -- 
		(1)  plots the deletion diagnostics against the predicted 
				probabilities
		(2) colors the observations according to the confidence 
				interval displacement diagnostic 
*/
