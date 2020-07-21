# HW03
## Assignment
Read in some data and graph something in R

### Is that it?
Yep. 

### Uhhh...? I can graph anything?
Yes, but I do have several notes and tips about this assignment:  

The idea for this assignment is to use the skills you learned in importing data into R (base read functions or readr functions) and to do some data exploration/visualization with that data. You are free to make any graph(s). Ideally more than one if the graphs you are making are simple to make but it could just be one graph that involves some extra formatting or extra special *pizazz*. A good idea might be to graph some data from lab that you previously graphed in Excel or using Graphpad/Prism. This would require putting the data in the repository, reading in the data, and creating a graph. Your code should have both reading in data and graphing, but otherwise you are free to make this about anything you want.  

I will say HW02 set you up to recreate a graph/image in R. The original idea for this homework is that you'd do more graph mimicking, but instead you would mimic graphs you previously created or graphs you care about (see note number 5). However, if you have lab meeting next week and you need to graph some new results and want to kill two birds with one stone, then be my guest. 

Note #1: We haven't yet hit the data wrangling/manipulation section, so do be mindful that the data you import should be formatted reasonably so you can graph it. We haven't gotten to it, but formatting is 80% of coding so if you pick a completely random dataset, it most likely will not be formatted in a way that will be compatible with ggplot. You can try to fix it in R if you are up to the challenge or you can do it in excel. That isn't the part I'm interested in you practicing this week.

Note #2: you can choose to code using an R script or R markdown. I introduced scripts or Rmds as a preference, so I want you to be able to choose, but there are notes for each. 
  * If you use an Rmd, you should really knit it to make a markdown document github can read. To do this create a new R markdown and choose any option (html will be the simplest) but change the output in the yaml header from "html_document" to be github_document (no quotes, see HW02 for an example).
  * IF you use a .R (R script), you should really save the figure (look into ggsave) and have that as an image file in your repository so your peers can check their results vs your own results. 

Note #3, remember that there is a file size limit of 100 MB. Don't commit a file that large! You **will** regret it. If you need a dataset larger than this, there are a couple of options: 1. only use a small portion of that dataset. 2. put it up on Box or something with instructions to download it. Or even better: 3. Include a way to download it into your repository programmatically (using R code, such as download.file or something similar). If you put large datasets into your repository and don't want to commit it, be sure to include the file name in the .gitignore. 

Note #4, remember to edit this Readme file and explain what you are doing!

Note #5, if you are trying to update or remake a graph you have previously made, it would be a good idea to include the original image in the repository.

Note #6, remember that these Github pages are public repositories, anyone could find them so don't use sensitive data or data your lab doesn't want to be somewhere on the internet. IF you really want to use data you'd rather keep private, email me separately. You could use a private repository and set your team members up as collaborators so only they can peer review, which is a small hassle but doable. There is no option to have it completely private. After all, I do have to look at it.   

#### What if need some ideas?
Idea #1: Remake a figure from your own, a lab's, or any publication or data portal where you can get your hands on the data

Idea #2: There are a ton of statistics on COVID cases and the increase over time. Try remaking one of those? You can even use [NY Times's Github Repository](https://github.com/nytimes/covid-19-data) and download the raw data from there!

Idea #3: Gapminder is a common dataset for students to explore [here](https://www.gapminder.org/data/). It has data on countries. E.g. wealth, child mortality, access to electricity, etc. and the data may suprise you. They even made a [TED talk about it](https://www.gapminder.org/ignorance/)

Idea #4: Explore [some census data](https://www.census.gov/data/datasets.html) or some survey data from the CDC. The CDC conducts 2 annual surveys the [Behavioral Risk Factor Surveillance System (BRFSS)](https://www.cdc.gov/brfss/about/index.htm) and [National Health and Nutrition Examination Survey (NHANES)](https://www.cdc.gov/nchs/nhanes/about_nhanes.htm). The BRFSS is conducted as a yearly phone survey of 400,000 adults, with data going back to 1995. The NHANES is unique in that it has a physical examination portion instead of self-reported data, but because of this, it only contains data on 5,000 people per year. Both are great potential datasets for those interested in health as the CDC uses this data to calculate prevelance rates on things from happiness to smoking to obesity. (These data might not be in the best format for graphing and will likely require some formatting to be able to plot in ggplot).


Explanation:
I tried processing the data to have more insightful graphs, but ended up getting issues, so I thought it would be nice instead to do a bar plot with cases of covid per states, but include death percentage from those cases per state. I'm not 100% sure if I managed the data right, but I know the main point of this assignment is to play with the plot features, and so I did with the new techniques taught from this past week's data camp lessons.