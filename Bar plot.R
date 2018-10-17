#This generates a bar graph. How neat.
#In this program, you would change the input file that points to "data"
#the variable after "barplot(data$*************," and text(data$***********," 

data <-(`2018.A.Field.Study.Memento.Aggregated.Germ`)

midpts <- barplot(data$Germination,
                  cex.axis = .8, cex.names = 0.4,
                  ylim = c(0, 65), main = "Average Germination Rates"
)

text(data$Variety,
     x = midpts,
     offset = -0.1,
     y = -10,
     cex = 1,
     srt = 60,
     xpd = TRUE,
     pos = 2 )
