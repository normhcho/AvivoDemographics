Avivo Demographics Markdown File
=====================================

The purpose of this is provide some basic demographic data that was presented to Avivo on March 12,2018 and incorporates the changes, most notably a distinict 18 to 26 age group, from that meeting

The sources are the custom made demographics data and the discharge portion of the Daanes file.  
For the demographics data, I calculated age at time of the discharge.  For race, I broke out the original race column and created 4 separate columns to make the data tidy (one variable per column).  Please not that these are the number of unique patients as identified by Client.Number.  Because there are clients with multiple visits, the number of patients is smaller than the number of visits.

Contents include:

* Previewing the data

* Counts by sex, primary race (race), and age grouping (age)

* Counts and percentages by age/sex, race/sex, age/race

* Success Rate by sex, race, and age

* Highest success rate by age/sex, race/sex, age/race

* Success rate by all 3 demographic categories



Accessing and setting up the data:

```r
demo <- read.csv("AvivoDemographicTablev3.csv",header = TRUE, sep=",")
library(data.table)
```

```
## data.table 1.10.4.3
```

```
##   The fastest way to learn (by data.table authors): https://www.datacamp.com/courses/data-analysis-the-data-table-way
```

```
##   Documentation: ?data.table, example(data.table) and browseVignettes("data.table")
```

```
##   Release notes, videos and slides: http://r-datatable.com
```

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:data.table':
## 
##     between, first, last
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2)
library(stringr)
opts_knit$set()
```

Previewing the data:

```r
dim(demo)
```

```
## [1] 1577   10
```

```r
summary(demo)
```

```
##    Client.Number    Date.of.Birth  Last.Discharge.Date Age.at.Discharge
##  10007    :   1   1/1/1984 :   3   10/28/2016:  10     Min.   :18.00   
##  10023    :   1   1/1/1986 :   3   12/15/2017:  10     1st Qu.:30.00   
##  10026    :   1   7/26/1989:   3   9/16/2016 :  10     Median :38.00   
##  111155766:   1   1/1/1963 :   2   10/13/2017:   9     Mean   :38.52   
##  111155768:   1   1/1/1989 :   2   12/18/2015:   9     3rd Qu.:47.00   
##  111155775:   1   (Other)  :1380   2/10/2017 :   9     Max.   :71.00   
##  (Other)  :1571   NA's     : 184   (Other)   :1520     NA's   :184     
##       Sex                                    Race    
##  Female :679   Black or African American       :633  
##  Male   :712   White                           :370  
##  Unknown:  2   American Indian or Alaska Native:145  
##  NA's   :184   Other Race                      : 40  
##                Declined to Specify             : 31  
##                (Other)                         :134  
##                NA's                            :224  
##                               Race1    
##  Black or African American       :666  
##  White                           :418  
##  American Indian or Alaska Native:162  
##  Other Race                      : 40  
##  Declined to Specify             : 31  
##  (Other)                         : 36  
##  NA's                            :224  
##                                        Race2     
##                                           :1478  
##  American Indian or Alaska Native         :  30  
##  Black or African American                :  18  
##  Declined to Specify                      :  16  
##  Hispanic or Latino                       :  22  
##  Native Hawaiian or Other Pacific Islander:   4  
##  Other Race                               :   9  
##                                        Race3             Race4     
##                                           :1565             :1576  
##  American Indian or Alaska Native         :   4   Other Race:   1  
##  Declined to Specify                      :   2                    
##  Hispanic or Latino                       :   4                    
##  Native Hawaiian or Other Pacific Islander:   1                    
##  Other Race                               :   1                    
## 
```

```r
str(demo)
```

```
## 'data.frame':	1577 obs. of  10 variables:
##  $ Client.Number      : Factor w/ 1577 levels "10007","10023",..: 1530 1453 1454 1455 1456 1457 1458 1515 1516 1517 ...
##  $ Date.of.Birth      : Factor w/ 1325 levels "1/1/1955","1/1/1961",..: 190 1019 349 700 205 342 134 917 614 225 ...
##  $ Last.Discharge.Date: Factor w/ 628 levels "1/10/2016","1/11/2016",..: 134 480 6 300 117 468 68 197 596 410 ...
##  $ Age.at.Discharge   : int  44 47 56 54 40 54 50 63 62 55 ...
##  $ Sex                : Factor w/ 3 levels "Female","Male",..: 2 2 2 1 1 2 1 1 1 1 ...
##  $ Race               : Factor w/ 32 levels "American Indian or Alaska Native",..: 7 7 7 18 18 7 7 7 7 7 ...
##  $ Race1              : Factor w/ 8 levels "American Indian or Alaska Native",..: 3 3 3 8 8 3 3 3 3 3 ...
##  $ Race2              : Factor w/ 7 levels "","American Indian or Alaska Native",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Race3              : Factor w/ 6 levels "","American Indian or Alaska Native",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Race4              : Factor w/ 2 levels "","Other Race": 1 1 1 1 1 1 1 1 1 1 ...
```


**Count by Single Variable Graphs**

Count by sex graph:

```r
ggplot(data=demo, aes(x=Sex)) + 
     geom_bar(mapping= aes(fill=Sex)) +
     ggtitle("Count of Avivo Clients by Sex") +
     geom_text(stat='count',aes(label=..count..),vjust=0)
```

![plot of chunk sex_graph](figure/sex_graph-1.png)

Fairly evenly divided between male and female.  What is notable is the number of NAs (184 or 12%)

Count by primary race graph:

```r
ggplot(data=demo, aes(x=Race1)) + 
     geom_bar(mapping= aes(fill=Race1)) +
     ggtitle("Count of Avivo Clients by Primary Race") +
     geom_text(stat='count',aes(label=..count..),vjust=0) +
     theme(axis.text.x=element_blank(),axis.ticks.x=element_blank()) +
     xlab("Primary Race")
```

![plot of chunk race_graph](figure/race_graph-1.png)

Because race for demographic purposes is calculated by primary race, I broke the primary race by the first value in the race column from the Daanes file.  African-Americans make up roughly half of the non-NA population, followed by patients who are White and then Native Americans.  Hispanic or Latino and Asians appear in very small numbers.


For the age grouping, I changed the age grouping to include 18 and 26 and then segmenting the other age groups by 10 year intervals until reaching age 57.  Note age is as of the discharge date.  This was done by changing the factor for age to numeric and using arbitrary cut points, but generally by decade.


```r
demo[4] <- lapply(demo[4], as.numeric)

demo$Age_group <- cut(demo$Age,
           breaks = c(-Inf, 27, 37, 47, 57, Inf),
           labels = c("18 to 26", "27 to 36", "37 to 46", "47 to 56", "57+"),
           right = FALSE)
```

Count by age grouping graph:

```r
ggplot(data=demo, aes(x=Age_group)) + 
     geom_bar(mapping= aes(fill=Age_group)) +
     ggtitle("Count of Avivo Clients by Age Grouping") +
     geom_text(stat='count',aes(label=..count..),vjust=0) +
     theme(axis.text.x=element_blank(),axis.ticks.x=element_blank()) +
     xlab("Age Grouping")
```

![plot of chunk age_graph](figure/age_graph-1.png)

The majority of the patients are between 18 and 49 years old.  There is a drop in the 50-59 age range and then it drops significantly at 60.

**Count by 2 Variable Graphs**

With the 2 variable graphs, I need to explain how to read the graphs.  The y-axis values are represented by the height of the bar.  That was done to show scale.  The value is the percentage within the x-axis variable.


Dataframe establishing count by age and sex:

```r
agesex <- demo %>%
    group_by(Age_group,Sex) %>%
    summarize(counts = n()) %>%
    mutate(percent_total = round(counts / sum(counts) * 100,1))
```


Count by age and sex graph:

```r
ggplot(data=agesex, aes(x=Age_group, y=counts, fill=Sex))+
    geom_bar(stat="identity",position = 'dodge') +
    geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), vjust = -0.5, size = 3) +
    ggtitle("Percent of Avivo Clients per Age Grouping by Sex")+
    xlab("Age Grouping")
```

![plot of chunk age_sex_graph](figure/age_sex_graph-1.png)

Almost 60% of the clients aged 18 to 36 are female, it is even distribution from 37 to 46, and roughly 70% of the clients aged 47+ are male.  In conclusion, there is a shift from female to male as the clientele is older.


dataframe establishing count by primary race and sex:

```r
primaryrace_sex <- demo %>%
    group_by(Race1,Sex) %>%
    summarize(counts = n()) %>%
    mutate(percent_total = round(counts / sum(counts) * 100,1))
```

Percent by age and sex graph:


```r
ggplot(data=primaryrace_sex, aes(x=Race1, y=counts, fill=Sex))+
    geom_bar(stat="identity",position = 'dodge') +
    geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), vjust = -0.5, size = 3) +
    ggtitle("Percent of Avivo Clients per Primary Race by Sex")+
    xlab("Age Grouping") + ylab("Counts") + 
    scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
```

![plot of chunk race_sex_graph](figure/race_sex_graph-1.png)

Almost 2/3 of the African-American patients are male, while over 80% of the Native American patients are female.


Dataframe establishing count by primary race and age group:

```r
primaryrace_agegroup <- demo %>%
  group_by(Race1,Age_group) %>%
  filter(Race1 %in% c("American Indian or Alaska Native","Black or African American","White")) %>%
  summarize(counts = n()) %>%
  mutate(percent_total = round(counts / sum(counts) * 100,1))
```

Percent by race and age graph


```r
ggplot(data=primaryrace_agegroup, aes(x=Race1, y=counts, fill=Age_group))+
  geom_bar(stat="identity",position = 'dodge') +
  geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), vjust = -0.5, size = 3) +
  ggtitle("Percent of Avivo Clients per Primary Race by Age Group")+
  xlab("Age Grouping") + ylab("Counts") + 
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
```

![plot of chunk race_age_graph](figure/race_age_graph-1.png)

Given that there were 3 main primary races in the population, the data has been filtered to American Indian or Alaska Native, African-American and White.  The age distribution for American Indian and White show that over 50% of the clients are under age 37 while for African-Americans, 65% of the clients are aged 37 and over.

**Success by single demographic variable graphs**

Before getting into these graphs, the count now shifts from the number of patients to the number of visits.  As a result the demographic and discharge data needs to be merged.

Taking only the discharge data because it this point it the same as the admission data and then merging it with the demographic data:


```r
avivo <- read.csv("admission_discharge_demographic.csv")
avivo_disc <- subset(avivo, avivo$Form.Flag == "discharge")
avivo_disc_demo <- merge(avivo_disc, demo, by="Client.Number")
```

Setting up variable indicating completion for Completed/Transferred:

```r
avivo_disc_demo$Completed_Program <- 0
avivo_disc_demo$Completed_Program <- ifelse (avivo_disc_demo$Reason.for.Discharge %in% c("Completed program","Transferred to other program"), 1, 0)
avivo_disc_demo$Completed_Program <- as.factor(avivo_disc_demo$Completed_Program)
```


Dataframe establishing success rate by sex (gender)


```r
df_success_sex <- avivo_disc_demo %>%
  group_by(Sex.y, Completed_Program) %>%
  summarize(counts = n()) %>% 
  mutate(percent_total = round(counts / sum(counts) * 100,1))
```

Success Rate by sex graph:


```r
ggplot(data = df_success_sex, aes(x = Sex.y, y = counts, fill = Completed_Program))+ 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), vjust = -0.5, size = 3) +
  xlab("Sex") + ylab("Count") +
  ggtitle("Success Rate by Sex") + 
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
```

![plot of chunk success_sex_graph](figure/success_sex_graph-1.png)

Females have a higher success rate than males.  Note that the NA success rate is higher than both.

Dataframe establishing success rate by primary race.  It is filtered by the three primary races.


```r
df_success_race<- avivo_disc_demo %>%
  group_by(Race1, Completed_Program) %>%
  filter(Race1 %in% c("American Indian or Alaska Native","Black or African American","White")) %>%
  summarize(counts = n()) %>% 
  mutate(percent_total = round(counts / sum(counts) * 100,1))
```

Success rate by primary race graph:


```r
ggplot(data = df_success_race, aes(x = Race1, y = counts, fill = Completed_Program))+ 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), vjust = -0.5, size = 3) +
  xlab("Primary Race") + ylab("Percent") +
  ggtitle("Success Rate by Primary Race") + 
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
  theme(axis.text=element_text(size=8))
```

![plot of chunk success_race_graph](figure/success_race_graph-1.png)

African Americans have the highest completion rates.  They are 5 points higher over Whites and 11 points over American Indians.

Dataframe establishing success rate by age group:

```r
df_success_age<- avivo_disc_demo %>%
  group_by(Age_group, Completed_Program) %>%
  summarize(counts = n()) %>% 
  mutate(percent_total = round(counts / sum(counts) * 100,1))
```

Success rate by age group graph:


```r
ggplot(data = df_success_age, aes(x = Age_group, y = counts, fill = Completed_Program))+ 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), vjust = -0.5, size = 3) +
  xlab("Age Group") + ylab("Count") +
  ggtitle("Success Rate by Age Group") + 
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
```

![plot of chunk success_age_graph](figure/success_age_graph-1.png)

Basically, the older the client, the more likely the client will succeed with a noticeable jump starting at age 47.

**Success by 2 demographic variables graphs**

The part shows the success rate by 2 variables but rather than show all values, the highest are shown.  Size is also not taken into account.

Dataframes establishing success rate by age group and sex:

```r
df_success_agesex <- avivo_disc_demo %>%
  group_by(Age_group, Sex.y, Completed_Program) %>%
  summarize(counts = n()) %>% 
  mutate(percent_total = round(counts / sum(counts) * 100,1))

df_success_agesex$agesex <- paste(df_success_agesex$Age_group, df_success_agesex$Sex.y, sep="_")
```
Filtering out the unknowns:

```r
df_success_agesex_comp <- subset(df_success_agesex, Completed_Program == 1, Sex.y != "Unknown")
```

Success rate by age/sex group graph but only showing the success rate and ranked:

```r
ggplot(data = df_success_agesex_comp, aes(reorder(x = agesex,percent_total), y = percent_total, fill = percent_total))+ 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), hjust = 0, size = 3) +
  xlab("Age Group") + ylab("Count") +
  ggtitle("Success Rate by Age/Sex Group, Overall = 43%") + 
  coord_flip() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))+
  theme(axis.text=element_text(size=8))
```

![plot of chunk success_age_sex_graph](figure/success_age_sex_graph-1.png)

Generally what is shows is that older patients are doing better.  Male patients aged 18 to 26, 27 to 36, and 37 to 46 comprise of the bottom 3 groups. 

Dataframes establishing success rate by primary race and sex.  

```r
df_success_racesex <- avivo_disc_demo %>%
  group_by(Race1, Sex.y, Completed_Program) %>%
  filter(Race1 %in% c("American Indian or Alaska Native","Black or African American","White")) %>%
  summarize(counts = n()) %>% 
  mutate(percent_total = round(counts / sum(counts) * 100,1))

df_success_racesex$racesex <- paste(df_success_racesex$Race1, df_success_racesex$Sex.y, sep="_")
```

Filtering out the unknowns:

```r
df_success_racesex_comp <- subset(df_success_racesex, Completed_Program == 1, Sex.y != "Unknown")
```

Success rate by primary race/sex graph but only showing the success rate and ranked:

```r
ggplot(data = df_success_racesex_comp, aes(reorder(x = racesex,percent_total), y = percent_total, fill = percent_total))+ 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), hjust = 0, size = 3) +
  xlab("Primary Race / Sex") + ylab("Percent") +
  ggtitle("Success Rate by Primary Race/Sex Group, Overall = 43%") + 
  coord_flip() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))+
  theme(axis.text=element_text(size=8))
```

![plot of chunk success_race_sex_graph](figure/success_race_sex_graph-1.png)

African American females have the highest success rates.  Native American males have the lowest rates.

Dataframes establishing success rate by primary race and sex:

```r
df_success_raceage <- avivo_disc_demo %>%
  group_by(Race1, Age_group, Completed_Program) %>%
  filter(Race1 %in% c("American Indian or Alaska Native","Black or African American","White")) %>%
  summarize(counts = n()) %>% 
  mutate(percent_total = round(counts / sum(counts) * 100,1))

df_success_raceage$raceage <- paste(df_success_raceage$Race1, df_success_raceage$Age_group, sep="_")

df_success_raceage_comp <- subset(df_success_raceage, Completed_Program == 1)
```

Success rate by primary race/age group graph but only showing the success rate and ranked:


```r
ggplot(data = df_success_raceage_comp, aes(reorder(x = raceage,percent_total), y = percent_total, fill = percent_total))+ 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), hjust = 0, size = 2) +
  xlab("Primary Race / Age") + ylab("Percent") +
  ggtitle("Success Rate by Primary Race/Age Group, Overall = 43%") + 
  coord_flip() +
  theme(axis.text=element_text(size=6))
```

![plot of chunk success_race_age_graph](figure/success_race_age_graph-1.png)

**Success by all demographic variables graph**

Using all 3 demographic categories but filtering by the 3 primary races and excluding the aged 57+ clientele, and finally setting the number of completed patients by 15+.

```r
df_success_all <- avivo_disc_demo %>%
  group_by(Race1, Sex.y, Age_group, Completed_Program) %>%
  filter(Race1 %in% c("American Indian or Alaska Native","Black or African American","White"),
         Age_group %in% c("18 to 26","27 to 36","37 to 46","47 to 56")) %>%
  summarize(counts = n()) %>% 
  mutate(percent_total = round(counts / sum(counts) * 100,1))

df_success_all$all <- paste(df_success_all$Race1,df_success_all$Sex.y ,df_success_all$Age_group, sep="_")

df_success_all_comp <- subset(df_success_all, Completed_Program == 1)

counts_not_small <- df_success_all_comp$counts > 14

df_success_all_comp_not_small <- df_success_all_comp[counts_not_small,]
```

Success rate by all 3 demographic categories but only showing the success rate and ranked:

```r
ggplot(data = df_success_all_comp_not_small, aes(reorder(x = all, percent_total), y = percent_total, fill = percent_total))+ 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_text(aes(label=percent_total),color='black',position = position_dodge(width = 1), hjust = 0, size = 2) +
  xlab("Primary Race / Age") + ylab("Percent") +
  ggtitle("Success Rate by all Factors, Completed Clients >= 15") + 
  coord_flip() +
  theme(axis.text=element_text(size=6))
```

![plot of chunk success_all_graph](figure/success_all_graph-1.png)

First, the age/gender/race categories where the number of completed clients below 15 were omitted.  There is one population that doesn't fit the overall story, which is that the younger age groups, 18 to 26 and 27 to 36, has the lowest success rate.  The African-American female population in those age groups has success rates of 53.3% (24 out of 45) and 48.9% (44 out of 90), which are both above average.  Are possible factors, the type of program or the possibility of the impact of children?





