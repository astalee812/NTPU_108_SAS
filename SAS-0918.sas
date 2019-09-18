/*純粹輸入會因為字元不夠導致字被切掉*/
data ds10a;
input name $ age award $ 30. bpalce $ lang $30. wight hight; /*變數若為文字，則要在變數後面加上"$"，字元數設定則是在$後加入需要的字元數*/
cards;
吳慷仁  33       第51屆男主角獎
高雄  中台客英語
57  177
柯佳嬿    31       第51屆女主角獎
台北  中台英日語
43   166
run;
/*把資料印出來*/
proc print data=ds10a;
run;
/*挑變數去讀取資料*/
data ds10a;
input #1 name $ age #3 wight hight; /* #是用來做選取欄位的符號 */
cards;
吳慷仁  33       第51屆男主角獎
高雄  中台客英語
57  177
柯佳嬿    31       第51屆女主角獎
台北  中台英日語
43   166
run;
/*把資料印出來*/
proc print data=ds10a;
run;
/* */
data ds10a;
input name$ age award $ 30.
					/bplace $ lang $ 30.
					/wight hight;
cards;
吳慷仁  33       第51屆男主角獎
高雄  中台客英語
57  177
柯佳嬿    31       第51屆女主角獎
台北  中台英日語
43   166
run;
/*把資料印出來*/
proc print data=ds10a;
run;
/* */
data ds10a;
input name$ age award $ 30. bplace $ lang $ 30. wight hight @@;
cards;
吳慷仁  33       第51屆男主角獎
高雄  中台客英語
57  177
柯佳嬿    31       第51屆女主角獎
台北  中台英日語
43   166
run;

 /*使用路徑的方式把資料讀入*/
data ds1;
infile "C:\Users\ASUS\Downloads\statpack104fch1d1.dat";
input trt mi counts;
run;
proc print data =  ds1;
run;

/* 文字檔有逗號相隔，使用delimiter或dlm處理 */
data ch1d5;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d5.dat" delimiter=",";
input id $ grade1 grade2 grade3 grade4;
proc print; run;

/* 路徑太長可以使用%let命名，以後都可以用這個路徑 */
%let indir = C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體; /*indir可以自己設定要用什麼字*/
data ch1d5;
infile "&indir\statpack104fch1d5.dat" dlm=",";
input id $ grade1 grade2 grade3 grade4;
run;
proc print; run;
/*指定從第幾個開始讀取*/
data ch1d6;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d6.txt" firstobs=40; 
input  FTP UEMP MAN LIC GR CLEAR WM NMAN GOV HE WE HOM ACC ASR @@;
run;
proc print; run;



