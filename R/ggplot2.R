


########################################
########## ggplots 2

install.packages('ggplot2')

library(ggplot2)
ggplot(data= mtcars, aes(x= wt, y=mpg)) +   #aesthetics
      geom_point() +                        #geometric objects
      labs(title='Automobile', x='weight', y='miles')



ggplot(data= mtcars, aes(x= wt, y=mpg)) +  
  geom_point(pch=17, color='blue', size=2) +                        
  geom_smooth(method='lm', color='red', linetype=2)
  labs(title='Automobile', x='weight', y='miles')


########## Grouping and Faceting
  
mtcars$am <- factor(mtcars$am, levels=c(0,1), 
                      labels=c('Automatic', 'Manual'))
mtcars$vs <- factor(mtcars$vs, levels=c(0,1), 
                      labels=c('V-Engine', 'Straight Engine'))
mtcars$cyl <- factor(mtcars$cyl)


#make kinda moscaic but cooler
ggplot(data=mtcars, aes(x=hp, y=mpg, shape=cyl, col=cyl)) +
      geom_point(size=3) +
      facet_grid(am~vs)  +
      labs(title='Engine type', x='Horsepower', y='Mpg')


########## Plot types with geom

#histogram
data(singer, package = 'lattice')
ggplot(singer, aes(x=height)) +
      geom_histogram()


#box
ggplot(singer, aes(x=voice.part, y=height)) + 
      geom_boxplot()


#notched box
data(Salaries, package = 'car')
ggplot(Salaries, aes(x=rank, y=salary)) +
      geom_boxplot(fill='cornflowerblue', 
                  color='black', notch=TRUE)+
      geom_point(position='jitter', color='blue', alpha=0.5) +
      geom_rug(sides='l', color='black')
  
  
#combined violin and box plot
ggplot(singer, aes(x=voice.part, y=height)) +
      geom_violin(fill='lightblue') +
      geom_boxplot(fill='lightgreen', width=0.2)



########## Grouping

#densities
ggplot(data=Salaries, aes(x=salary, fill=rank)) +
      geom_density(alpha=0.3)


#grouping using colors and shapes
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank, 
                      shape=sex)) + geom_point()


#stacked bars
ggplot(Salaries, aes(x=rank, fill=sex)) +
      geom_bar(position='stack') +labs(title='position="stack"')

#separated bars
ggplot(Salaries, aes(x=rank, fill=sex)) +
      geom_bar(position='dodge') + labs(title='position="dodge"')

#normalize to 1
ggplot(Salaries, aes(x=rank, fill=sex)) +
      geom_bar(position='fill') + labs(title='position="fill"')

ggplot(Salaries, aes(x=rank, fill=sex)) + geom_bar()
ggplot(Salaries, aes(x=rank)) + geom_bar(fill='red')
ggplot(Salaries, aes(x=rank, fill='red')) + geom_bar()




########## Faceting

#histogram
ggplot(data=singer, aes(x=height)) + 
      geom_histogram() +
      facet_wrap(~voice.part, nrow=4)

#points 
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank, 
                     shape=rank)) + geom_point() + facet_grid(~sex)


#densities
ggplot(data=singer, aes(x=height, fill=voice.part)) +
      geom_density() + 
      facet_grid(voice.part~.)



########## Adding smooth lines

ggplot(Salaries, aes(x=yrs.since.phd, y=salary)) +
      geom_smooth() + geom_point()


ggplot(Salaries, aes(x=yrs.since.phd, y=salary, linetype=sex, shape=sex, color=sex)) +
  geom_smooth(method=lm, formula=y~poly(x,2), se=FALSE) + geom_point()
  geom_point(size=2)


  
  

########## Modifying the appearance
  
data(Salaries, package = 'car')
  
### Axes

#boxplot, adjust the x/y ticks with labels
ggplot(data=Salaries, aes(x=rank, y=salary, fill=sex)) +
      geom_boxplot() + 
      scale_x_discrete(breaks=c('AsstProf', 'AssocProf', 'Prof'), 
                       labels=c('asiprof', 'asoprof', 'prof'))      +
      scale_y_continuous(breaks=c(50000, 100000, 150000, 200000),
                         labels=c('$50k','$100k', '$150k', '$200k')) +
      labs(title='Faculty', x='', y='')
  
  
  
### Legends

ggplot(data=Salaries, aes(x=rank, y=salary, fill=sex)) +
      geom_boxplot() + 
      scale_x_discrete(breaks=c('AsstProf', 'AssocProf', 'Prof'), 
                       labels=c('asiprof', 'asoprof', 'prof'))  +
      scale_y_continuous(breaks=c(50000, 100000, 150000, 200000),
                     labels=c('$50k','$100k', '$150k', '$200k')) +      
      labs(title='Faculty', x='', y='', fill='Gender') +
      theme(legend.position=c(0.1, 0.8))
      
  
### Scales

ggplot(mtcars, aes(x=wt, y=mpg, size=disp)) +
      geom_point(shape=21, color='black', fill='cornsilk') +
      labs(x='weight', y='miles per gallon', 
            title='bubble chart', size='Engine\nDisplacement')
  
  
ggplot(data=Salaries, aes(x=yrs.since.phd, y=salary, color=rank)) +
      scale_color_brewer(palette='Set1') + #values=c('orange', 'olivedrab', 'navy')) +
      geom_point(size=2)
   

### Themes

mytheme <- theme(plot.title=element_text(face="bold.italic",
                                         size="14", color="brown"),
                 axis.title=element_text(face="bold.italic",
                                         size=10, color="brown"),
                 axis.text=element_text(face="bold", size=9,
                                        color="darkblue"),
                 panel.background=element_rect(fill="white",
                                               color="darkblue"),
                 panel.grid.major.y=element_line(color="grey",
                                                 linetype=1),
                 panel.grid.minor.y=element_line(color="grey",
                                                 linetype=2),
                 panel.grid.minor.x=element_blank(),
                 legend.position="top")

ggplot(Salaries, aes(x=rank, y=salary, fill=sex)) + 
      geom_boxplot() +
      labs(title='salary', x='rank', y='salary')  +
      mytheme



### Multiple graphs

p1 <- ggplot(data=Salaries, aes(x=rank)) + geom_bar()
p2 <- ggplot(data=Salaries, aes(x=sex)) + geom_bar()
p3 <- ggplot(data=Salaries, aes(x=yrs.since.phd, y=salary)) + geom_point()


library(gridExtra)
grid.arrange(p1, p2, p3, ncol=3)


###saving graphs

ggplot(data=mtcars, aes(x=mpg)) + geom_histogram()
ggsave(file='mygraph.pdf')




  
  
  
