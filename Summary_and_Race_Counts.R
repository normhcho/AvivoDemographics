## Importing the Demographics File with the summary

> demo <- read.csv("AvivoDemographicTablev2.csv",header = TRUE, sep=",")
> summary(demo)
   Client.Number  Date.of.Birth       Age             Sex                                    Race    
 10007    :   1   1/1/84 :   3   Min.   :19.00   Female :679   Black or African American       :633  
 10023    :   1   1/1/86 :   3   1st Qu.:31.00   Male   :712   White                           :370  
 10026    :   1   7/26/89:   3   Median :39.00   Unknown:  2   American Indian or Alaska Native:145  
 111155766:   1   1/1/63 :   2   Mean   :40.09   NA's   :184   Other Race                      : 40  
 111155768:   1   1/1/89 :   2   3rd Qu.:49.00                 Declined to Specify             : 31  
 111155775:   1   (Other):1380   Max.   :74.00                 (Other)                         :134  
 (Other)  :1571   NA's   : 184   NA's   :184                   NA's                            :224  
                              Race1                                           Race2     
 Black or African American       :666                                            :1478  
 White                           :418   American Indian or Alaska Native         :  30  
 American Indian or Alaska Native:162   Black or African American                :  18  
 Other Race                      : 40   Declined to Specify                      :  16  
 Declined to Specify             : 31   Hispanic or Latino                       :  22  
 (Other)                         : 36   Native Hawaiian or Other Pacific Islander:   4  
 NA's                            :224   Other Race                               :   9  
                                       Race3             Race4     
                                          :1565             :1576  
 American Indian or Alaska Native         :   4   Other Race:   1  
 Declined to Specify                      :   2                    
 Hispanic or Latino                       :   4                    
 Native Hawaiian or Other Pacific Islander:   1                    
 Other Race                               :   1   


## Counts of particular races

## Number of patients whose primary or secondary race is Black or African American

> countBlack <- length(which(demo$Race1=="Black or African American")) + length(which(demo$Race2=="Black or African American")) + 
length(which(demo$Race3=="Black or African American")) + length(which(demo$Race4=="Black or African American"))
> countBlack
[1] 684

## Number of patients whose primary race is Black or African American

> countBlackPrimary <- length(which(demo$Race1=="Black or African American"))
> countBlackPrimary
[1] 666

## Number of patients whose primary or secondary race is White

> countWhite <- length(which(demo$Race1=="White")) + length(which(demo$Race2=="White")) + length(which(demo$Race3=="White")) + 
length(which(demo$Race4=="White"))
> countWhitePrimary <- length(which(demo$Race1=="White"))
> countWhite
[1] 418
> countWhitePrimary
[1] 418

## Number of patients whose primary or secondary race is American Indian or Alaska Native

> countNative <- length(which(demo$Race1=="American Indian or Alaska Native")) + 
length(which(demo$Race2=="American Indian or Alaska Native")) + 
length(which(demo$Race3=="American Indian or Alaska Native")) + 
length(which(demo$Race4=="American Indian or Alaska Native"))
> countNative

## Number of patients whose primary is American Indian or Alaska Native

[1] 196
> countNativePrimary <- length(which(demo$Race1=="American Indian or Alaska Native"))
> countNativePrimary
[1] 162
