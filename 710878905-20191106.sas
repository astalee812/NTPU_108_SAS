libname dir "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��";
/*Chapter 3, page 17*/
proc print data=dir.tennis (obs=10);
run;

proc format;
	value x3f 1="�k" 2="�k";
	value x5f 1="���`" 2="�y�j" 3="�L�j";
	value x6f 1="��" 2="�A��" 3="��" 4="�����D";
	value x7f 1="���Y" 2="�T" 3="�����ֺ�" 4="�۾�" 5="��" 6="�X��" 7="��L";
	value x8f 1="���s�u" 2="�z�u" 3="�����D";
run;

data tennis;
set dir.tennis;
format x3 x3f. 
  x5 x9 x5f.
  x6 x10 x6f.
  x7 x11 x7f.
  x8 x12 x8f.;
run;
proc print data=tennis (obs=10) label;
run;

data tennis;
set tennis;
where x5 ne 9 and x8 ne 9;
run;

proc gchart data=tennis;
/*hbar x7/discrete descending type=percent;*/
/*hbar x7/discrete cfreq percent percentlabel="����";*/
/*hbar x7/discrete ;*/
/*hbar x7/discrete autoref;*/
/*hbar x7/discrete autoref ref=(25,30) clipref;*/
/*hbar x7/discrete caxis=red cframe=green coutline=yellow ctext=pink;*/
/*hbar x7/discrete width=10 space=5 woutline=3;*/
hbar x7/discrete;
hbar x7/discrete autoref lautoref=3 wautoref=3;
run;

proc gchart data=tennis;
/*hbar x7/discrete descending type=percent; /*�������y�жb�ܼ� �åB�������ܼƦW�� �����Ƨ� �M��Φʤ���*/
hbar x7/discrete freq cpercent cpercentlabel="����"; /*��w����ǭn�e�{����T ���� �β֭p�ʤ��� */
hbar x7/discrete autoref ref=(25,30) clipref;/*���Ѧҽu �b25,30 �[�W�u ��u�è�᭱*/
hbar x7/discrete autoref lautoref=3 wautoref=6;/*�Ѧҽu�ʲ�*/
hbar x7/discrete caxis=red cframe=yellow coutline=purple ctext=brown ;/*�W��*/
hbar x7/discrete width=10 space=5 woutline=3;/*�վ�e�� ���Z ����ϥ~�ؽu*/
run;

proc gchart data=tennis;
hbar x3/discrete autoref clipref type=pct freq group=x7
hbar x3/discrete autoref clipref type=pct freq group=x7/*group�i�N��Ƥ���*/
gspace=2;
hbar x3/discrete clipref type=pct freq subgroup=x8/*subgroup�i�N����u�X�֦b�@�_��ܡA����N��A�A�Ŧ�N��B*/
gspace=2;
hbar x3/discrete clipref type=pct freq subgroup=x8 group=x7
gspace=2;
run;

proc freq data=tennis;
table x3*x7/chisq;
table x7*x3*x8;
run;

/*�O�b!! �O�b!! �O�b��!!*/
/*�b�O�i�H�Q�s����!*/
proc gchart data=tennis;
hbar x3/discrete;
run;
axis label=("��") offset=(1cm, 2cm);
proc gchart data=tennis;
hbar x3 / discrete raxis=axis;
run;

axis major = (height = 1cm color=blue);
proc gchart data=tennis;
hbar x3 / discrete raxis=axis;
run;

axis minor= none;
proc gchart data=tennis;
hbar x3 / discrete raxis=axis;
run;

axis minor= (height = 1cm color=red number=2);
proc gchart data=tennis;
hbar x3 / discrete raxis=axis;
run;

axis label=(angle=90 "Gender");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; /*�ק�M�b*/
run;

axis label=( "Gender");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

axis label=(rotate=45 "Gender");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

axis value=(color=blue "BB"  color=red "GG");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

axis value=(tick=1 color=blue "BB" j=r "oy" 
					  tick=2 color=red "GG");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

axis order= (2 1);
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

goptions reset=axis;/*��b�]�w���ѱ�*/
goptions reset=all; /*��Ҧ��]�w���ѱ�*/

legend1 label=("ABC") value=("N" "G");
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend1; 
run;

legend1 label=("ABC") value=("N" "G")
				position=(top left inside); /*�����������خؤ�*/
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend1; 
run;

legend1 label=("ABC") value=("N" "G")
				position=(bottom right inside); /*�����������خؤ�*/
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend1; 
run;

legend2 origin=(3cm 2cm);
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend2; 
run;

legend2 offset=(1cm 2cm) origin=(3cm 2cm);
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend2; 
run;

legend3 order=(2 1) shape=bar(10,2);
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend3; 
run;

axis1 order=(5 2 3 1 4);
proc gchart data=tennis;
hbar x3 / discrete group=x7 subgroup=x8 gaxis=axis1; 
run;

proc means data=tennis;
var x2;
run;

proc gchart data=tennis;
hbar x2/space=0 range levels=5; /*levels�O��ƭȤ�������*/
run;

proc gchart data=tennis;
hbar x2/space=0 range midpoints=(17 to 62 by 5);
run;

proc gchart data=tennis;
hbar x2/space=0 range midpoints=(17 to 62 by 5)discrete; /*��Ǥ����A�Ʀr*/
run;

proc gchart data=tennis;
hbar x2/space=0 range levels=5;
vbar x2/space=0 range width=10;
block x2/levels=5;
run;

proc gchart data=tennis;
hbar x2/space=0 range  midpoints=(15 to 65 by 10);
vbar x2/space=0 range  midpoints=(15 to 65 by 10) width=10;
block x2/ midpoints=(15 to 65 by 10);
run;

proc gchart data=tennis;
pie x2/ midpoints=(15 to 65 by 10);
run;

proc gchart data=tennis;
block x5 / discrete group=x3 subgroup=x8; /*���骽���! �M�ᦳ����*/
run;

proc gchart data=tennis;
pie x5/ discrete;
run;

proc gchart data=tennis;
pie x5/ discrete angle=95;
run;

proc freq data=tennis;
table x5;
run;
proc gchart data=tennis;
pie x5/ discrete angle=95;
run;

proc gchart data=tennis;
pie x5/ discrete explode=(1 3); /*���Ϭ�X!*/
run;

proc gchart data=tennis;
pie x5/ noheading descending clockwise ;
run;

proc gchart data=tennis;
pie x5/ noheading descending clockwise other=23 otherlabel="other" ;
run;

proc gchart data=tennis;
pie3d x5/ discrete explode=(2 3);
run;

proc gchart data=tennis;
pie x5/ discrete value=arrow detail=x8;
run;