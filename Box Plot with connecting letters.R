#This code was adapted from https://cran.r-project.org/web/packages/multcompView/multcompView.pdf
#This runs a one way ANOVA and generates a box and whisker plot with connecting letters
#To use this program change the name of the file on line 11 that points to "data"
#Change the "Plot" in "data$Plot" and "Weight" in  "data$Weight" to what ever your
#Treatment and response variables are.
#You will also need to adjust ylab and title. If you want horiz x axis text change "las=1" on line 32

library(multcompView)

#data <-(`2018.Field.Study.Heights.and.Weights.Aggregated`)
data <-(`2018.Field.Study.Heights.and.Weights`)

Treatment <- data$Plot
Response <- data$Weight


model=lm( Response ~ Treatment )
ANOVA=aov(model)
TUKEY <- TukeyHSD(x=ANOVA, 'Treatment', conf.level=0.95)
generate_label_df <- function(TUKEY, Response){
  
  # Extract labels and factor levels from Tukey post-hoc
  Tukey.levels <- TUKEY[[Response]][,4]
  Tukey.labels <- data.frame(multcompLetters(Tukey.levels)['Letters'])
  
  #I need to put the labels in the same order as in the boxTreatment :
  Tukey.labels$Treatment=rownames(Tukey.labels)
  Tukey.labels=Tukey.labels[order(Tukey.labels$Treatment) , ]
  return(Tukey.labels)
}

LABELS=generate_label_df(TUKEY , "Treatment")
a=boxplot(Response ~ Treatment , ylim=c(min(Response) , 1.1*max(Response)) , ylab="Weight g." , main="Quinoa Seed Head Weights by Replicate", cex.axis=0.8, space = 1, las = 2)
over=0.1*max( a$stats[nrow(a$stats),] )
text( c(1:nlevels(Treatment)) , a$stats[nrow(a$stats),]+over , LABELS[,1])

