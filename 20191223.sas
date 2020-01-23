/*independent model*/
proc genmod data= ch7d1;
class g i s;
model count=g i s / link=log dist=poisson;
run;
/*Marginal model*/
/*/GI S*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*i/ link=log dist=poisson;
run;
/*這邊多加的!*/
/*Resid如果是負的，就是高估!*/
/*Marginal model*/
/*/GI S*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*i/ link=log dist=poisson;
output out=gi_p p=pred resraw=resid; /*Resid = 個數-預測值*/
run;

/*Marginal model*/
/*/GS I*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*s/ link=log dist=poisson;
run;

/*Marginal model*/
/*/IS G*/
proc genmod data= ch7d1;
class g i s;
model count=g i s I*S/ link=log dist=poisson;
run;

/*下一步我們該分析哪一個呢? 進入邊際條件*/
/*conditional model*/
/*GI IS*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*i i*s/ link=log dist=poisson;
run;
/*Homo*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*i i*s g*s/ link=log dist=poisson;
run;
/*當兩個變數有uniform的特性(單調)就可以使用*/
data ch7d1a;
set ch7d1;
si=s*i;  /*多一個相乘變數，就可以建立線性by線性模型*/
run;
/*Linear by Linear model for IS---只需要增加一個自由度就可以解釋IS*/
/*因為Model 5的IS有太多自由度! 所以我把IS相乘! 變成只要一個自由度
BUT!!!! 不是所有變相都可以相乘，要挑顯著的!!!(哪裡顯著???看Margin的model! GI已經先固定了! SI的AIC比較好)
*/
proc genmod data= ch7d1a;
class g i s;
model count=g i s g*i si/ link=log dist=poisson;
run;


/*GI跟IS都比independent重要，AIC感覺GI會比較好*/
/*   G_df = 2-1 = 1
Model                                  LogLinear                       AIC(要有減少)
1.Independent                       59.7620                           125.8676              df = 1+1+(4-1)+(4-1) = 8
2.Marginal GI*S                      66.0375                           119.3165              df = 8+(4-1) = 11
3.Marginal GS*I                      60.4144                           130.5627              df = 8+(4-1) = 11
4.Marginal SI*G                      66.4957                           130.4033              df = 8+(4-1)*(4-1) = 17
5.Conditional GI IS                 72.7712                           123.8492              df = 17+1*3 = 20
Homo ===> 這個模型沒有收斂! hessian not positive definite 
6.LL GI                                     70.0890                           113.2137              df = 11 (Model2+1=12)    

Model 4 vs Model 5 ===>   2(72.77 - 66.50) = 12.54  >  chisq(20-17) = 7.81  reject H0 (表示Model 5比較好)
Chisq(20 - 17) = 7.81===>這個數字是查表來的，兩個df相減
Model 2 vs Model6 ===> 2(70.0890 - 66.0375) = 8.103 > chisq1^2 = 3.84 reject H0 (表示Model 6比較好)
Model 6 vs Model 5 ===>2(72.7712 - 70.0890) = 5.3644 < chisq8^2 = 15.50731 not reject H0 (表示Model 6比較好)
*/



/* cmh結果看哪個? (ch7 p62)
linear by linear 是看非零相關  ---  因為自由度比較少，檢定力相對也會高一點
飽和模型是看一般關聯性
非零相關 tho = 0
列平均技術 mu1 = mu2 = mu3
一般關聯性  r=0
*/
proc freq data=ch7d1;
weight count;
tables g*i*s/cmh;
run;
