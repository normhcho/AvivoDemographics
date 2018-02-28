## Breakdown by Gender

ggplot(data=demo) + stat_count(mapping = aes(Sex, fill=Sex)) + ggtitle("Percentage of Avivo Clients by Sex")

## Breakdown by Primary Race

ggplot(data=demo) + stat_count(mapping = aes(Race1, fill=Race1)) + ggtitle("Percentage of Avivo Clients by Primary Race") + 
theme(axis.text=element_text(size=5)) + xlab("Primary Race")

## Breakdown by Age

ggplot(data=demo) + stat_count(mapping = aes(Age)) + ggtitle("Percentage of Avivo Clients by Age")
