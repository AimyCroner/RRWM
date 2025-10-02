***CAnD3 RRWM 1***

cd "/Users/AimyCroner/Desktop/CANDYRRWM"

*Importing the data set 

import delimited "GSS.csv", clear

***Cleaning our data***

**Creating a dummy variable for physical health of respondents (DV of interest)

gen physhealth = srh_110

*recode missings

recode physhealth 7=. 8=. 9=.

*create a binary for physical health 

gen physhealth_dummy = physhealth

*create 2 categories for health (good or poor)
*0=good
*1=poor

replace physhealth_dummy = 0 if physhealth == 1
replace physhealth_dummy = 0 if physhealth == 2
replace physhealth_dummy = 0 if physhealth == 3
replace physhealth_dummy = 1 if physhealth == 4
replace physhealth_dummy = 1 if physhealth == 5
 

*create labels for categories 

label define physhealth_dummy 0 "Good" 1 "Poor"
label values physhealth_dummy physhealth_dummy
tab physhealth_dummy, m

**Create a categorical variable for age 

*agec = age of respondents at time of the survey interview
gen age = agec

*Drop respondents who are younger than 20 and older than 65 - focusing on respondents within the "working age"
*Note: no missing data points for age  

drop if age < 20 | age > 65
tab age 

*creating categories for age 
gen age_group = age 

replace age_group = 1 if age >= 20 & age <= 29
replace age_group = 2 if age >= 30 & age <=39
replace age_group = 3 if age >= 40 & age <= 49
replace age_group = 4 if age >=50 & age <= 59
replace age_group = 5 if age >= 60 & age <=65

*labeling categories for age 
label define age_group 1 "20-29" 2 "30-39" 3 "40-49" 4 "50-59" 5 "60-65"
label values age_group age_group
tab age_group, m

save GSS.dta

**Create a dummy variable for marital status 

*marstat = marital status of the respondent 
gen marital = marstat

*recode missings 

recode marital 97=. 98=.  

*creating dummy variable 

*0=Single
*1=Married/Common Law

*Dropping single people 

drop if marital == 3
drop if marital == 4
drop if marital == 5
drop if marital == 6

gen marital_dummy = marital

replace marital_dummy = 0 if marital == 2
replace marital_dummy = 1 if marital == 1

*label categories 

label define marital_dummy 0 "Living Common law" 1 "Married"
label values marital_dummy marital_dummy
tab marital_dummy, m

**create a categorical variable for main activity of spouse 

gen spousestat = map_110

*recode missings 

recode spousestat 96=. 97=. 98=. 99=.  

*create new categories 

recode spousestat 1=1 2=2 3=3 4=4 5=4 6=5 7=4 8=5 9=4 10=6

*label categories 

label define spousestat 1 "Working" 2 "Unemployed / Job seeking" 3 "Studying" 4 "Homemaking / Caregiving" 5 "Not in labour force" 6 "Other"
label values spousestat spousestat
tab spousestat, m 

**creating dummy variable for spouse work status 

gen spouswrkstat = map_130

*recode missings 

recode spouswrkstat 6=. 7=. 8=. 9=. 

*create a dummy variable 

gen spouswrkstat_dummy = spouswrkstat

*create categories 
*0= working
*1 = not working 

replace spouswrkstat_dummy = 0 if spouswrkstat == 1
replace spouswrkstat_dummy = 1 if spouswrkstat == 2

*label categories 

label define spouswrkstat_dummy 0 "Paid job or self-employed in last 12 mos" 1 "Not employed in last 12 mos"
label values spouswrkstat_dummy spouswrkstat_dummy
tab spouswrkstat_dummy, m

**create categorical variable for spouse work schedule 

gen spwrksched = map_155

*recode missings 

recode spwrksched 96=. 97=. 98=. 99=.

*create new categories 

recode spwrksched 1=1 2=2 3=2 4=3 5=4 6=3 7=3 8=4

*create labels

label define spwrksched 1 "Day Shift/Standard" 2 "Evening/Night shift" 3 "Rotating / Irregular shift" 4 "Split shift or other"
label values spwrksched spwrksched
tab spwrksched, m

**Creating dummy variable for respondent's wortk status 

*WORKLYR = respondents worked at paid job or business last year (yes or no) *note: could not find a better variable for current employment status 

gen employ = worklyr

*No missing values to recode for employment status 

*create a dummy variable 

gen employ_dummy = worklyr

*create categories 
*0= did not work in last year 
*1=worked in last year 

replace employ_dummy = 0 if employ == 2
replace employ_dummy = 1 if employ == 1

*Label catgeories in employ

label define employ_dummy 1 "Worked last yr" 0 "Did not work last yr"
label values employ_dummy employ_dummy 
tab employ_dummy, m

**Creating a dummy sex variable 

gen sexa = sex

*No missing values to recode for sex

*create a dummy variable 

gen female = sexa

*creating categories 
*0=Male
*1=Female 

replace female = 0 if sexa == 1
replace female = 1 if sexa == 2

*Label categories in sex 

label define female 0 "Male" 1 "Female"
label values female female 
tab female, m

save "GSS.dta", replace 

**Creating categorical variable for respondent's education level

gen edu = ehg3_01b 

*recode missings 

recode edu 97=. 98=. 99=.

*creating new categories for education

*less than a HS degree or equivalent (1), high school degree or equivalent (2), college and trade certificate (3-4), University degree or certificate (5-6-7) 

recode edu 1=1 2=2 3=3 4=3 5=4 6=4 7=4

*label categories in education 

label define edu 1 "Less than a high school degree" 2 "High school degree or equivalent" 3 "College or Trade Certifcate" 4 "University degree or equivalent trade certificate"
label values edu edu 
tab edu, m

**Creating a categorical variable for family income 

gen famincome = famincg2

*no missings to recode 

*creating new categories for income 
*less than 25k, 25-49, 50-74, 75-99, 100+

recode famincome 1=1 2=2 3=3 4=4 5=5 6=5 

*labelling categories for income 

label define famincome 1 "less than $25k" 2 "$25k-$49,999k" 3 "$50k-74,999k" 4 "$75k-99,999k" 5 "$100k +"
label values famincome famincome 
tab famincome, m 

*creating a categorical variable for average hours worked per week 

gen weekhours = uhw_16gr

*recode missing values

recode weekhours 7=. 8=. 9=. 

*valid skips (6) here are our unemployed category - worklyr shows us that those who said they did not work in the past year are unemployed (7087) - this same number is present in our uhw_16gr variable where valid skips are 7087 respondents = they are our unemployed category 
**labelling them as unemployed rather than missing 

**labelling categories for hours worked 

label define weekhours 1 "0 hrs" 2 "less than 30 hrs" 3 "30-40 hrs" 4 "40.1-50 hrs" 5 "50.1+ hrs" 6 "Unemployed"
label values weekhours weekhours
tab weekhours, m 


save "GSS.dta", replace

***Descriptives table ***

summarize physhealth_dummy age_group marital_dummy spousestat spouswrkstat_dummy spwrksched employ_dummy sex edu famincome weekhours


***Table 1: Self-rated physical health by spouse main acitivty in the last 12 months***

*DV: SR physical health of respondent
*IV: spouse main activity 

tabulate physhealth_dummy spousestat, row

***Table 2: Self-rated physical health by spouse employment status in last 12 months***

*DV: SR physical health of respondent
*IV: spouse employment status in last 12 months

tabulate physhealth_dummy spouswrkstat_dummy, row

***Table 3: Self-rated physical health by spouse work schedule type***

tabulate physhealth_dummy spwrksched, row

***Regressions of interest***

*Regression 1: whether spouse main activity has an effect on respondent's physical health

logistic physhealth_dummy spousestat i.age_group marital_dummy employ_dummy female i.edu i.famincome i.weekhours 
**not significant 
**Weekhours omitted due to colinearity

*Regression 2: whether spouse employment status in past 12 months has an effect on respondent's physical health 

logistic physhealth_dummy spouswrkstat_dummy i.age_group marital_dummy employ_dummy female i.edu i.famincome i.weekhours 
*not significant 
**Weekhours omitted due to colinearity

*Regression 3: whether spouse work schedule has an effect on the respondent's physical health

logistic physhealth_dummy i.spwrksched i.age_group employ_dummy female i.edu i.famincome i.weekhours marital_dummy
*not significant
**Weekhours omitted due to colinearity


 
 