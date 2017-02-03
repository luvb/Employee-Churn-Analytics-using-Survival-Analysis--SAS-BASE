/*EXPLORATORY DATA ANALYSIS
Checking Attrition rate with respect to each covariate*/

*Define Permanent Library;
LIBNAME Lib "P:\OPIM5894\Library";
DATA Lib.raw1;
INFILE "P:\OPIM5894\Library\fermalogis.csv" DLM=',' MISSOVER DSD firstobs=2  ;
INPUT X Obsv Age Attr $  Bsns_Trvl $ DailyRate Dpt $ DistFrmHome 
Educ EducField $ EmployeeCount EmployeeId EnvtSatisfctn 
Gender $ HrlyRate JobInvlvmnt JobLevel JobRole $ JobSatisfctn Marital_St $ 
MthlyInc MthlyRate NumComp_Worked Over18 $ OverTime $ Percent_Hike 
Perf_Rating Rltnshp_Satisfctn Standard_Hrs Stock_opt_Level 
Tot_Work_Yrs Trainings_LastYr WorkLife_Blnce Yrs_AtCompany 
Yrs_InCurrentRole Yrs_SinceLastPromotion Yrs_WithCurrManager b_1 $ b_2 $ 
b_3 $ b_4 $ b_5 $ b_6 $ b_7 $ b_8 $ b_9 $ b_10 $ b_11 $ b_12 $ 
b_13 $ b_14 $ b_15 $ b_16 $ b_17 $ b_18 $ b_19 $ b_20 $ b_21 $ 
b_22 $ b_23 $ b_24 $ b_25 $ b_26 $ b_27 $ b_28 $ b_29 $ b_30 $ 
b_31 $ b_32 $ b_33 $ b_34 $ b_35 $ b_36 $ b_37 $ b_38 $ b_39 $ b_40 $;
*Change attrition value from character to numeric(nominal);
if attr='Yes' then attr1=1;
if attr='No' then attr1=0;
run;

*Data Explorartion Plots;
PROC SGPLOT DATA = LIB.raw1;
VBAR JobRole / group=attr1 groupdisplay=cluster stat = percent;
TITLE "Jobrole vs Attrition";
RUN;

PROC SGPLOT DATA = LIB.raw1;
VBAR JobSatisfctn/ group = Attr groupdisplay=cluster stat = percent;
TITLE "JobSatisfaction vs Attrition";
RUN;

PROC SGPLOT DATA = LIB.raw1;
VBAR Bsns_Trvl/ group = Attr1 groupdisplay=cluster stat = percent;
TITLE "Business Travel vs Attrition";
RUN;

PROC SGPLOT DATA = LIB.raw1;
VBAR Dpt/ group = Attr1 groupdisplay=cluster stat = percent;
TITLE "Department vs Attrition";
RUN;

PROC SGPLOT DATA = LIB.raw1;
VBAR JobLevel/ group = Attr1 groupdisplay=cluster stat=percent;
TITLE "JobLevel vs Attrition";
RUN;

PROC SGPLOT DATA = LIB.raw1;
VBAR OverTime/ group = Attr1 groupdisplay=cluster stat=percent;
TITLE "OverTime vs Attrition";
RUN;

PROC SGPLOT DATA = LIB.raw1;
VBAR WorkLife_Blnce/ group = Attr1 groupdisplay=cluster stat=percent;
TITLE "Work Life Balance vs Attrition";
RUN;

PROC FREQ DATA = LIB.RAW1;
TABLES OverTime*attr1 / PLOTS=FREQPLOT(TWOWAY=GROUPHORIZONTAL);
TABLES JobLevel*attr1 / PLOTS=FREQPLOT(TWOWAY=GROUPHORIZONTAL);
TABLES WorkLife_Blnce*attr1 / PLOTS=FREQPLOT(TWOWAY=GROUPHORIZONTAL);
TABLES JobInvlvmnt*attr1 / PLOTS=FREQPLOT(TWOWAY=GROUPHORIZONTAL);
TABLES Perf_Rating*attr1 / PLOTS=FREQPLOT(TWOWAY=GROUPHORIZONTAL);
TABLES Gender*attr1 / PLOTS=FREQPLOT(TWOWAY=GROUPHORIZONTAL);
TITLE;
RUN;

PROC FREQ DATA = LIB.raw1;
TABLES Trainings_LastYr*attr1/ PLOTS=FREQPLOT(TWOWAY=GROUPHORIZONTAL);
TITLE 'Trainings since last year grouped by Attrition';
RUN;

PROC SGPLOT DATA = LIB.raw1;
VBOX MthlyInc / GROUP= Attr1 tip =(mean median);
RUN;

PROC LIFETEST DATA = lib.raw1;
TIME Yrs_AtCompany*attr1(0);
RUN;

PROC LIFETEST DATA=lib.raw1 PLOTS=S(CB=EP CL);	
TIME Yrs_AtCompany*attr1(0);
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany*attr1(0);
STRATA OverTime;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Trainings_LastYr (2 4 6)/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Bsns_Trvl/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Educ/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA EnvtSatisfctn/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Gender/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA JobInvlvmnt/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA JobLevel/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA JobSatisfctn/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Marital_St/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA JobRole/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Perf_Rating/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA WorkLife_Blnce/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Marital_St Age(20 30 40 50 60)/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Marital_St Age(20 30 40 50 60)/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA Age(20 30 40 50 60)/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA MthlyInc(2000 4000 6000 8000 100000)/ ADJUST=BON;
RUN;

PROC LIFETEST DATA = lib.raw1 PLOTS=S(test);
TIME Yrs_AtCompany *attr1(0);
STRATA DailyRate(300 600 900 1500) /ADJUST= TUKEY;
RUN;

PROC LIFETEST DATA = lib.raw1;
TIME Yrs_AtCompany *attr1(0);
STRATA Yrs_InCurrentRole;
RUN;

PROC LIFETEST DATA = lib.raw1 METHOD = life PLOTS = (S,H)
INTERVALS = 0 10 20 30 40;
TIME Yrs_AtCompany*attr1(0);
STRATA OverTime;
RUN;

/*MODELING ALL THE COVARIATES*/

*Define Permanent Library;
LIBNAME Lib "P:\OPIM5894\Library";
DATA Lib.raw1;
INFILE "P:\OPIM5894\Library\fermalogis.csv" DLM=',' MISSOVER DSD firstobs=2  ;
INPUT X Obsv Age Attr $  Bsns_Trvl $ DailyRate Dpt $ DistFrmHome 
Educ EducField $ EmployeeCount EmployeeId EnvtSatisfctn 
Gender $ HrlyRate JobInvlvmnt JobLevel JobRole $ JobSatisfctn Marital_St $ 
MthlyInc MthlyRate NumComp_Worked Over18 $ OverTime $ Percent_Hike 
Perf_Rating Rltnshp_Satisfctn Standard_Hrs Stock_opt_Level 
Tot_Work_Yrs Trainings_LastYr WorkLife_Blnce Yrs_AtCompany 
Yrs_InCurrentRole Yrs_SinceLastPromotion Yrs_WithCurrManager b_1 $ b_2 $ 
b_3 $ b_4 $ b_5 $ b_6 $ b_7 $ b_8 $ b_9 $ b_10 $ b_11 $ b_12 $ 
b_13 $ b_14 $ b_15 $ b_16 $ b_17 $ b_18 $ b_19 $ b_20 $ b_21 $ 
b_22 $ b_23 $ b_24 $ b_25 $ b_26 $ b_27 $ b_28 $ b_29 $ b_30 $ 
b_31 $ b_32 $ b_33 $ b_34 $ b_35 $ b_36 $ b_37 $ b_38 $ b_39 $ b_40 $;
*Change attrition value from character to numeric(nominal);
if attr='Yes' then attr1=1;
if attr='No' then attr1=0;
run;

*Loglikelihood of full and null model;
PROC LIFEREG DATA=lib.raw1;   *null model to test null hypothesis;
	MODEL Yrs_AtCompany*attr1(0)= / D=WEIBULL; /*Loglikelihood of null hypothesis*/
RUN;

PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St
/ D=WEIBULL; /*Loglikelihood of null hypothesis*/
PROBPLOT;
RUN;

*Check if full model is better than null model;
DATA calculateLogRatio;
	L_null = -794.9924028;
	L_full = -404.0629149;
	
	L = 2 * ABS(L_full - L_null);
	p_value = 1 - probchi(L,30);
RUN;

PROC PRINT data = calculateLogRatio;
RUN;

*Goodness of fit curve for full model;
PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=LNORMAL; /*Loglikelihood of null hypothesis*/
PROBPLOT;
RUN;

PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager 
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St
/ D=EXPONENTIAL; /*Loglikelihood of null hypothesis*/
RUN;

PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=GAMMA; /*Loglikelihood of null hypothesis*/
RUN;

*Compare Models;
DATA CompareModels;
	L_exponential = -513.7749834;
	L_weibull = -404.0629149;
	L_lognormal = -412.8842858;
	L_gamma = -326.3527419;
	
	LRTEG = -2*(L_exponential - L_gamma);
	LRTEW = -2*(L_exponential - L_weibull);
	LRTWG = -2*(L_weibull - L_gamma);
	LRTLG = -2*(L_lognormal - L_gamma);

	p_valueEG = 1 - probchi(LRTEG,2);
	p_valueEW = 1 - probchi(LRTEW,1);
	p_valueWG = 1 - probchi(LRTWG,1);
	p_valueLG = 1 - probchi(LRTLG,1);
RUN;

PROC PRINT DATA=CompareModels;
RUN;

*Full model built using Lognormal distribution;
PROC LIFEREG DATA=lib.raw1;   
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=LOGNORMAL;
RUN;

*LOGNORMAL model build using only significant covariates;
PROC LIFEREG DATA=lib.raw1;
CLASS Bsns_Trvl OverTime Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome EnvtSatisfctn
MthlyInc NumComp_Worked Stock_opt_Level JobInvlvmnt 
JobSatisfctn Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion NumComp_Worked Yrs_WithCurrManager Bsns_Trvl OverTime Marital_St 
/ D=LNORMAL;
PROBPLOT;
RUN;

/*MODELING WITH STRATA COVARIATES*/

*Define Permanent Library;
LIBNAME Lib "P:\OPIM5894\Library";
DATA Lib.raw1;
INFILE "P:\OPIM5894\Library\fermalogis.csv" DLM=',' MISSOVER DSD firstobs=2  ;
INPUT X Obsv Age Attr $  Bsns_Trvl $ DailyRate Dpt $ DistFrmHome 
Educ EducField $ EmployeeCount EmployeeId EnvtSatisfctn 
Gender $ HrlyRate JobInvlvmnt JobLevel JobRole $ JobSatisfctn Marital_St $ 
MthlyInc MthlyRate NumComp_Worked Over18 $ OverTime $ Percent_Hike 
Perf_Rating Rltnshp_Satisfctn Standard_Hrs Stock_opt_Level 
Tot_Work_Yrs Trainings_LastYr WorkLife_Blnce Yrs_AtCompany 
Yrs_InCurrentRole Yrs_SinceLastPromotion Yrs_WithCurrManager b_1 $ b_2 $ 
b_3 $ b_4 $ b_5 $ b_6 $ b_7 $ b_8 $ b_9 $ b_10 $ b_11 $ b_12 $ 
b_13 $ b_14 $ b_15 $ b_16 $ b_17 $ b_18 $ b_19 $ b_20 $ b_21 $ 
b_22 $ b_23 $ b_24 $ b_25 $ b_26 $ b_27 $ b_28 $ b_29 $ b_30 $ 
b_31 $ b_32 $ b_33 $ b_34 $ b_35 $ b_36 $ b_37 $ b_38 $ b_39 $ b_40 $;
*Change attrition value from character to numeric(nominal);
if attr='Yes' then attr1=1;
if attr='No' then attr1=0;
run;

*Loglikelihood of full and null model;
PROC LIFEREG DATA=lib.raw1;   *null model to test null hypothesis;
	MODEL Yrs_AtCompany*attr1(0) / D=WEIBULL; /*Loglikelihood of null hypothesis*/
RUN;

PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome EnvtSatisfctn
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager 
/ D=WEIBULL; /*Loglikelihood of null hypothesis*/
RUN;

*Check if full model is better than null model;
DATA calculateLogRatio;
	L_null = -794.9924028;
	L_full = -497.0680146;
	
	L = 2 * ABS(L_full - L_null);
	p_value = 1 - probchi(L,30);
RUN;

PROC PRINT data = calculateLogRatio;
RUN;

*Check goodness of fit for full model;
PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome EnvtSatisfctn
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager 
/ D=LNORMAL; /*Loglikelihood of null hypothesis*/
RUN;

PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome EnvtSatisfctn
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager 
/ D=EXPONENTIAL; /*Loglikelihood of null hypothesis*/
RUN;

PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome EnvtSatisfctn
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager 
/ D=GAMMA; /*Loglikelihood of null hypothesis*/
RUN;

*Compare Models;
DATA CompareModels;
	L_exponential = -586.2122897;
	L_weibull = -497.0680146;
	L_lognormal = -488.7339387;
	L_gamma = -461.4671591;
	
	LRTEG = -2*(L_exponential - L_gamma);
	LRTEW = -2*(L_exponential - L_weibull);
	LRTWG = -2*(L_weibull - L_gamma);
	LRTLG = -2*(L_lognormal - L_gamma);

	p_valueEG = 1 - probchi(LRTEG,2);
	p_valueEW = 1 - probchi(LRTEW,1);
	p_valueWG = 1 - probchi(LRTWG,1);
	p_valueLG = 1 - probchi(LRTLG,1);
RUN;

PROC PRINT DATA=CompareModels;
RUN;

*Lognormal model build using all covariates;
PROC LIFEREG DATA=lib.raw1;   *FULL model to test null hypothesis;
CLASS Bsns_Trvl Dpt EducField OverTime JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome EnvtSatisfctn
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
Joblevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime JobRole Marital_St 
/ D=LNORMAL;
PROBPLOT;
RUN;

*LOGNORMAL model build using only significant covariates;
PROC LIFEREG DATA=lib.raw1; 
CLASS Bsns_Trvl OverTime;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome EnvtSatisfctn
MthlyInc NumComp_Worked Stock_opt_Level JobInvlvmnt 
JobSatisfctn Tot_Work_Yrs Yrs_InCurrentRole 
Yrs_SinceLastPromotion NumComp_Worked Yrs_WithCurrManager Bsns_Trvl OverTime
/ D=LOGNORMAL;
PROBPLOT;
RUN;

/*CATEGORIZING DATA WITH RESPECT TO TENURE*/

*Define Permanent Library;
LIBNAME Lib "P:\OPIM5894\Library";
DATA Lib.raw2;
INFILE "P:\OPIM5894\Library\fermalogis.csv" DLM=',' MISSOVER DSD firstobs=2  ;
INPUT X Obsv Age Attr $  Bsns_Trvl $ DailyRate Dpt $ DistFrmHome 
Educ EducField $ EmployeeCount EmployeeId EnvtSatisfctn 
Gender $ HrlyRate JobInvlvmnt JobLevel JobRole $ JobSatisfctn Marital_St $ 
MthlyInc MthlyRate NumComp_Worked Over18 $ OverTime $ Percent_Hike 
Perf_Rating Rltnshp_Satisfctn Standard_Hrs Stock_opt_Level 
Tot_Work_Yrs Trainings_LastYr WorkLife_Blnce Yrs_AtCompany 
Yrs_InCurrentRole Yrs_SinceLastPromotion Yrs_WithCurrManager b_1 $ b_2 $ 
b_3 $ b_4 $ b_5 $ b_6 $ b_7 $ b_8 $ b_9 $ b_10 $ b_11 $ b_12 $ 
b_13 $ b_14 $ b_15 $ b_16 $ b_17 $ b_18 $ b_19 $ b_20 $ b_21 $ 
b_22 $ b_23 $ b_24 $ b_25 $ b_26 $ b_27 $ b_28 $ b_29 $ b_30 $ 
b_31 $ b_32 $ b_33 $ b_34 $ b_35 $ b_36 $ b_37 $ b_38 $ b_39 $ b_40 $;
*Change attrition value from character to numeric(nominal);
if attr='Yes' then attr1=1;
if attr='No' then attr1=0;
if Yrs_AtCompany < 3 then emp_type= "new employee";
if 3 <= Yrs_AtCompany< 5 then emp_type= "medium exp";
if Yrs_AtCompany >= 5 then emp_type= "experienced";
run;

PROC LIFETEST DATA = lib.raw2 PLOTS=S(test);
TIME Yrs_AtCompany*attr1(0);
STRATA emp_type/ adjust=tukey;
RUN;

data lib.new_emp;
set lib.raw2;
if emp_type= "new employee";
run;

data lib.med_exp;
set lib.raw2;
if emp_type= "medium exp";
run;

data lib.exp;
set lib.raw2;
if emp_type= "experienced";
run;

*Loglikelihood of Nested model;
PROC LIFEREG DATA=lib.raw2;
CLASS emp_type Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
emp_type Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=LNORMAL;
PROBPLOT;
RUN;

*Loglikelihood of new_employee model;
PROC LIFEREG DATA=lib.new_emp;  
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=LNORMAL; /*Loglikelihood of null hypothesis*/
PROBPLOT;
RUN;

*Loglikelihood of mid_exp model;
PROC LIFEREG DATA=lib.med_exp;  
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=LNORMAL; /*Loglikelihood of null hypothesis*/
PROBPLOT;
RUN;

*Loglikelihood of mid_exp model;
PROC LIFEREG DATA=lib.exp;  
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=LNORMAL; /*Loglikelihood of null hypothesis*/
PROBPLOT;
RUN;

*Compare Models;
DATA CompareModels;
	Nested = -258.571502;
	New_Employee= 26.145649584;
	Medium_Experience = 18.23671698;
	Experienced = -120.4530788;

	Total = sum(New_Employee,Medium_Experience,Experienced);
	Difference = ABS (Nested-Total);
	
	p_value = 1 - probchi(Difference,31);
RUN;

PROC PRINT data = CompareModels;
RUN;

*p-value = 0 thus we need to model each employee type separately;

*MODELING THE CATEGORIZED COVARIATES*/;

*Define Permanent Library;
LIBNAME Lib "P:\OPIM5894\Library";
*Model for New Employees;
PROC LIFEREG DATA=lib.new_emp; *With all covariates;
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D= lnormal;
PROBPLOT;
RUN;

PROC LIFEREG DATA=lib.new_emp; *With significant covariates;
CLASS OverTime;
MODEL Yrs_AtCompany*attr1(0)= DistFrmHome Perf_Rating 
NumComp_Worked Percent_Hike JobInvlvmnt 
JobSatisfctn Tot_Work_Yrs Yrs_InCurrentRole 
Yrs_SinceLastPromotion NumComp_Worked Yrs_WithCurrManager OverTime 
/ D=LNORMAL;
PROBPLOT;
RUN;

*Model for Medium Experienced employees;
PROC LIFEREG DATA=lib.med_exp; *With all covariates;
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=LNORMAL;
PROBPLOT;
RUN;

PROC LIFEREG DATA=lib.med_exp; *With Significant covariates;
CLASS OverTime;
MODEL Yrs_AtCompany*attr1(0)= EnvtSatisfctn
JobInvlvmnt JobSatisfctn Tot_Work_Yrs Yrs_InCurrentRole 
MthlyRate OverTime 
/ D=LNORMAL;
PROBPLOT;
RUN;

*Model for Experienced employees;
PROC LIFEREG DATA=lib.exp; *With all covariates;
CLASS Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St;
MODEL Yrs_AtCompany*attr1(0)= Age DistFrmHome Educ EnvtSatisfctn Perf_Rating 
Rltnshp_Satisfctn MthlyInc NumComp_Worked Percent_Hike Stock_opt_Level JobInvlvmnt 
JobLevel JobSatisfctn WorkLife_Blnce Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
Yrs_SinceLastPromotion DailyRate HrlyRate MthlyRate NumComp_Worked Yrs_WithCurrManager
Bsns_Trvl Dpt EducField OverTime Gender JobRole Marital_St 
/ D=LNORMAL;
PROBPLOT;
RUN;

PROC LIFEREG DATA=lib.exp; *With all significant covariates;
CLASS OverTime;
MODEL Yrs_AtCompany*attr1(0)= NumComp_Worked Stock_opt_Level
JobLevel JobSatisfctn Tot_Work_Yrs Trainings_LastYr Yrs_InCurrentRole 
DailyRate NumComp_Worked Yrs_WithCurrManager OverTime
/ D=LNORMAL;
PROBPLOT;
RUN;
