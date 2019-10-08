/* 1 */
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\homework\statpack104fHW4.xlsx"
out = hw4 dbms = xlsx replace;
getnames=no;
label a="id" b="age" c="gender" d="CaM" e="hypertension" f="diabetes" g="smoke" h="evaluation";
run;

/* 2 */
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\homework\statpack104fHW3_1.csv"
out=bank dbms=csv replace;
getnames=yes;
run;
data bank2;
set bank;
label id="�s��"
        salbeg="�_�~"
        age="�~��"
        salnow="�{�b���~��"
        edlevel="�Ш|�{��"
        work="�u�@�g��"
        jobscat="�u�@����"
        minority="�ر�"
  gender="�ʧO";
run;
proc format;
value jobscatf
 1 = "�ѰO" 2 = "�줽�ǤuŪ��" 3 = "�O��" 4= "�j�ǹ�ߥ�"
 5 = "�d������u" 6 = "�޲z���V��" 7 = "������u�{�v";
value minority  1 = "�դH" 2 = "�¤H";
run;

proc sort;by gender minority salnow;run;

proc print data=list label sumlabel; 
by  gender minority;
var id work age edlevel jobcat salnow;
format id id. work work. age age. edlevel edlevel. 
    jobcat jobcat. salnow salnow.;
sum salnow;
run;

/* 3 */
data old;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\homework\statpack104fHW3_2.txt";
input a $ 1 b $ 5-8 c 10/
        d e 5 / /
        f g h i j k /
  l 1-3 m 10-12 n o p;
label a="�~��"        b="�s��"        c="��F��"        d="�B��"        e="�~���p"        f="���d����"        g="���d����(�P�L�h�ۤ�)"
        h="������"  i="�}���f"  j="����"        k="�k�h"        l="����"        m="�魫"        n="�u�@���p"        o="���J���p"        p="���J";
run;
proc format;
value $a "A" = "50-66yrs(in 1996)" "B"="67+yrs(in 1996)";
value c 1 = "���ҥ�" 2 = "���ҥ�" 3 = "���ҥ�" 4= "��" 5 = "�m";
value d 1 = "�w�B�A�t�����b" 2 = "���P�~�Ѧ�" 3 = "�స�A���A�B" 
     4= "���B�A���A�B" 5 = "�������~" 6="�q�����B";
value e 1 = "���[��" 2 = "���y��" 3 = "����A�`����L�H" 
     4= "�D���[�~��b��" 5 = "��L" 9="����";
value f  1 = "�ܦn" 2 = "�n" 3="���q" 4="���Ӧn" 5="�ܤ��n";
value g  1 = "���n" 2 = "�t���h" 3="���t";
value h 1 = "��" 2 = "����" 0="�S���Τ����D";
value i  1 = "��" 2 = "����" 0="�S���Τ����D";
value j  1 = "��" 2 = "����" 0="�S���Τ����D";
value k  1 = "�S��" 2 = "���L����" 3="����" 4="���Y��(�i�Ԩ�)" 5="�D�`�Y��(�L�k�Ԩ�)" 8="���A��" 9="����";
value l  998 = "�����D" 999 = "����";
value m  998 = "�����D" 999 = "����";
value n  1 = "�ثe���u�@" 2 = "���@���u�@�A���ȮɨS���h��" 3="�����U�a���ͷN" 
   4="�S���u�@�A���b��u�@" 5="�a��" 6="�S�����W�z�u�@" 9="����";
value o  1 = "��" 0 = "�S��" 9="����";
run;
proc print data=old label ; 
by  a c;
var b f g h i j k;
format f f. g g. h h. i i. j j. k k.;
run;
proc print data=old (keep = a b c l m n o p) label sumlabel; 
where o=1;
by a c;
var l m n o p;
format l l. m m. n n. o o. p p.;
sum o p;
run;


/* 4 */
data d;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\homework\statpack104fHW2_2.txt";
input id$1-2 gender$3 mon$5-7 year 9-12 level 15 fee 16 amount$19-23 time 25 end$27-29 due 30;
label id="�|���s��" gender="�ʧO" mon="�J�|���" year="�J�|�~��" level="�J�|����" fee="�J�|����O" amount="�C����ú�|�O" time="�ϥήɬq" end="������" due="�����";
run;