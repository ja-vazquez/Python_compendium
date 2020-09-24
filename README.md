# * The Python compendium

This folder contains several scripts, notes and examples elaborated through many nights of coding (hopefully they'll be useful in future references). 
**N.B.** highly encouraged to recycle and make use of them in any possible way.
More elaborated examples may be found in the astro/cosmo folders within this GitHub account. 

As you can see from below, Python is the dominant language, however
due to the popularity of R I have added some standard notes, visualizations
and basic statistics examples.
There are also several SQL examples, based on SQLite and MYSQL, that have been tested with Pandas.
Finally, to integrate HTML, CSS, JS with Python and SQL, I included some files to create websites using Flask.


The majority of the content may be found spread around the web or throughout several books, but 
the bibliography I used, and possibly where all the info is coming from, 
is displayed on the bottom of the page.

x - means that I haven't had a chance to spend a considerable amount of time in that particular topic, but I am about to.

Before starting, have a look of  [Git](http://rogerdudler.github.io/git-guide/): A simple guide for getting started with git and
 [Git-SVN](http://git.or.cz/course/svn.html): Git - SVN Crash Course.

------

### Python

* [The basics](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Python/The_basics.ipynb): (lists, tuples, dictionaries, loops, etc).
* [The not so basics](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Python/The_not_so_basics.ipynb): (partial, map, reduce, filter, zip, decorators, etc).
* [iPython NB](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Python/iPython.ipynb): (magic commands, debugger, profiling).
* [Numpy](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Python/Numpy.ipynb) and [Numpy II](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Python/Numpy_II.ipynb): (Numerical Python).
* [Idiomatic Python](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Python/Idiomatic_Python.ipynb): (Transforming Code into Beautiful, Idiomatic Python).

    **Scicoder** 
    
	* [iPython NB](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/IPython_Nb.ipynb) --  [Matplotlib](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Matplotlib.ipynb) -- [Numpy](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Numpy.ipynb) -- [Advanced Pyhton](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Advanced_Python.ipynb).
	* Scipy : [Tour](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Scipy_bits_and_pieces.ipynb) -- [Integrate](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Scipy_integrate.ipynb) -- [Optimize](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Scipy_optimize.ipynb) -- [Optimize II](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Scipy_optimize_solutions.ipynb).
	* [Astropy](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Astropy.ipynb) -- [Cython](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scicoder/Cython.ipynb). 

### Getting data


* [Scraping the web](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Getting_data/Scraping_the_web.ipynb): (Beatiful Soup, requests).
	- O'Reilly Media: Plotting books published over the 'data' subject.
	- Yellow Pages: Get info for Coffee shops in NYC.
* [Scraping the web II](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Getting_data/Scraping_the_web_II.ipynb): (Parse, urlopen). 
	- Yahoo's finance, Options.	 Long Island Rail Road (XML).
* [Using Twython API](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Getting_data/Twython_API.ipynb): 
Getting tweets with hashtag (i.e. Data).
* [Searching for Quasars](http://nbviewer.jupyter.org/github/ja-vazquez/ForetFusion/blob/master/sdss_catalog.ipynb)(Mechanize).
	- Building a catalog of selecting qusars for the sdss collaboration. 

### Working with data 

* [Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/Pandas.ipynb) : Everything you should know about it. 
* [Writing and Reading files](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/Input_output.ipynb): Basic reading/writing csv files, and plotting with pandas.
* [Writing and Reading files II](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/Input_output_II.ipynb): Working with JSON, HDF5, XLS.
* [Data Analysis with Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/Data_Analysis_with_Pandas.ipynb): Examples: stocks, baby names, elections.
* [IPython Notebook & Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/IPythonNB_Pandas.ipynb): Correlation between people cycling and weather in Montreal. 



### R

* [Using other languages within R](https://github.com/ja-vazquez/Python_compendium/blob/master/PennState/Compiled_C_F/other_lang.R): Working 	with C/C++/Fortran/Python.
* [The basics](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Intro.R): Vectors, Matrices, Data Frames, Data input: Mysql.
	* [R Walkthrough](https://github.com/ja-vazquez/Python_compendium/blob/master/Scicoder/R_Walkthrough.pdf). From Scicoder Workshop.
* [Data management](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Data_management.R). Manipulating data.
* [Stats with R](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Basic_stats.R). Descriptive Statistics with R.
* [Descriptive Stats](https://github.com/ja-vazquez/Python_compendium/blob/master/PennState/Descriptive_statistics.R): Descriptive
	Statistics and Exploratory Analysis. Data Visualization. 


### Visualization


* [Basics of Matplotlib and pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Visualization/Visualizing_Data.ipynb): General Matplotlib intro, and some examples with pandas.
* [Basemap and Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Visualization/Pandas_Basemap.ipynb): Visualizing maps.
* [Bokeh](http://www.cosmo.bnl.gov/www/jvazquez/Plotting_with_Bokeh.html): Several plots with bokeh, including chisq distributions for quasars.
* [Constraints](http://nbviewer.jupyter.org/github/ja-vazquez/BOSS_files/blob/master/DR12/dr12_constraints.ipynb), [Getdist](http://getdist.readthedocs.org/en/latest/plot_gallery.html): Given MCMC chains, we're able to produce constraint plots.
* x - [Cartobd](http://docs.cartodb.com/tutorials/named_maps/) - Seaborn, Folium, Ploty
* [Creating graphs in R](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Creating_graphs.R): Working with graphs in R. 
* [Basic graphs in R](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Basic_graphs.R): Bars, Pie, Hist, Dots, etc.
* [More plots with R](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Intermediate_plots.R): Scatter, Corrgrams, Mosaic, etc.
* [ggplot2](https://github.com/ja-vazquez/Python_compendium/blob/master/R/ggplot2.R): An introduction to the package.
* x - [D3 Turorials](https://github.com/mbostock/d3/wiki/Tutorials)




### SQL

* [Interacting with databases (SQLite3)](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/SQL/Interacting_with_databases.ipynb): IPython notebook and Pandas connecting with SQLite.
* [MySQL basics](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_basic.sql) - [extras](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_extras.sql)  : Basic scripts to write SQL language. 
* [Queries](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_Queries.sql) - [Filtering](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_Filtering.sql) : Some examples on a database: Query clauses and filtering. 
* [Multiple tables](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_multiple_tables.sql) - [Sets](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_sets.sql) : Querying Multiple Tables and Working with sets.
* [Data Manipulation](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_data_manipulation.sql) - [Grouping and aggregation](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_grouping.sql) : String, numeric and temporal data. Grouping. 
* [MySQL DBs](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/TSQL_Example.sql) - [Countries](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/TSQL_countries.sql) - [Person](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/TSQL_person.sql). Some tables to practice over examples.
* [SQL-SkyServer](http://skyserver.sdss.org/dr13/en/tools/search/sql.aspx): Using SQL with SkyServer [SDSS - internal].






### Machine Learning, Stats and other magic tricks

* [Regression](https://github.com/ja-vazquez/Python_compendium/blob/master/PennState/Regression.R): Linear Regression, Confidence Ellipses and Bands. Polynomial regression. Non-linear Regression.
* [Bootstrapping](https://github.com/ja-vazquez/Python_compendium/blob/master/PennState/Bootstrapping.R): Parametric and Nonparametric Bootstrapping. 
* [Model Selection](https://github.com/ja-vazquez/Python_compendium/blob/master/PennState/Model_selection.R): AIC and BIC, R^2.
* [Gaussian, Bernoulli, Count models](https://github.com/ja-vazquez/Python_compendium/blob/master/Greece_ADA/ADA_R/Bernoulli/Ex4_Bernoulli_JAGS_x1.R): Fitting curves with JAGS.
* [Inverse problems](http://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/ML/inverse_problems.ipynb): Linear Regression, Gradient Descent.
* [Sparcity](http://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/ML/sparsity.ipynb): FFT, Denoising functions.
* [Wavelets](http://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/ML/wavelets.ipynb): Discrete Fourier Transform, Multiresolution Analysis.
* [Jack-knife and bootstrap resampling](https://github.com/ja-vazquez/Upsilon/tree/master/Results): Module to analize measurements of galaxy-galaxy weak lensing and galaxy clustering.


### Parallel Computing

* [Multiprocessing](https://github.com/ja-vazquez/Python_compendium/tree/master/multiprocessing). Plot a bunch of SDSS spectra in parallel via multiprocessing.
* [The GM-Sampler](https://github.com/ja-vazquez/GM_Sampler/blob/master/GM/game.py)  parallelize with [mpi4py](http://nbviewer.jupyter.org/github/ja-vazquez/GM_Sampler/blob/master/GM/Mpi4y.ipynb), [MPI with IPython](https://github.com/ipython/ipyparallel)
* [Example of GMSampler](http://nbviewer.jupyter.org/github/ja-vazquez/GM_Sampler/blob/master/GM/GMSampler.ipynb): one of the outcomes that uses a unimodal Gaussian likelihood. 

### Web

*   [Flask](https://github.com/ja-vazquez/Python_compendium/tree/master/Flask_Bokeh/): Flask using Bokeh for visualizations.
*   [Flask Frozen](https://github.com/ja-vazquez/Python_compendium/tree/master/Flask_Bokeh/): Flask_frozen and flask_pages to create a static website


----
------

#  Lecture notes -  Python 

* [1 - Basic Intro to the Notebook](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Curso_python/1_Intro_to_python.ipynb)
* [2 - Types and Operations](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Curso_python/2_Types_and_operations.ipynb)
* [6 - Files and Matplotlib](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Curso_python/6_Files_Matplotlib.ipynb)
* [7 - Symbolic python](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Curso_python/7_Symbolic_python.ipynb)
* [8 - Symbolic python II](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Curso_python/8_Symbolic_python.ipynb)
  
----
------

# * Conferences

* [Pydata](http://pydata.org/)
* [PyGotham](https://2016.pygotham.org/)
* [Database Camp](http://www.database.camp/)
* [Pycon](http://www.pycon.org/)

----
------





# * Bibliography

* [IPython tutorial](https://ipython.org/ipython-doc/2/interactive/tutorial.html)
* [Python for Data Analysis](http://www.amazon.com/Python-Data-Analysis-Wrangling-IPython/dp/1449319793)
* [ipython](https://github.com/ipython/ipython/wiki/A-gallery-of-interesting-IPython-Notebooks#statistics-machine-learning-and-data-science): collection of Jupyter notebooks.


### Data scraping 
		 
* [Beatiful Soup](https://www.crummy.com/software/BeautifulSoup/): Python library designed for quick turnaround projects like screen-scraping.
* [Scrapy](http://doc.scrapy.org/en/master/intro/tutorial.html): For building more complicated web-scrapers.
* [Requests](http://docs.python-requests.org/en/master/):
* [html5lib](https://pypi.python.org/pypi/html5lib):


### Data wrangling

* [Pandas](http://pandas.pydata.org/): Provides high-performance, easy-to-use data structures and data analysis tools.
* [Pandas Cookbook](https://github.com/jvns/pandas-cookbook) Gives concrete examples for getting started with pandas.

### Statistics and Probability

* [Scipy](http://www.scipy.org/): SciPy is a Python-based ecosystem of open-source software for mathematics, science, and engineering.
* [Statsmodels](http://statsmodels.sourceforge.net/devel/index.html): Provides classes and functions for the estimation of many different statistical models.
* [Scikit-learn](http://scikit-learn.org/stable/index.html): Machine Learning in Python
* [Astropy](http://www.astropy.org/)

### Databases

* x - [SQLite in Python](http://sebastianraschka.com/Articles/2014_sqlite_in_python_tutorial.html)
* x - [Zetcode](http://zetcode.com/)
* x - [SQLzoo](http://sqlzoo.net/wiki/SQL_Tutorial)
* x - [SQLschool](https://sqlschool.modeanalytics.com/)
* X - [Pyhton MySQL](http://www.mysqltutorial.org/python-mysql/)
* X - [RDB](https://lagunita.stanford.edu/courses/DB/2014/SelfPaced/about)
* X - [RDB2](https://www.udacity.com/course/intro-to-relational-databases--ud197)
* X - [SQLAlchemy](http://www.sqlalchemy.org/library.html#tutorials)
* X - [Tuturial SQLAlchemy](http://pythoncentral.io/introductory-tutorial-python-sqlalchemy/)

### R

* X - [New York City R conference](http://www.rstats.nyc/2016)
* X - [R-tutor](http://www.r-tutor.com/r-introduction)

### Visualizations

* [Matplotlib](http://matplotlib.org/): python 2D plotting library.
* [Seaborn](http://stanford.edu/~mwaskom/software/seaborn/): It provides a high-level interface for drawing attractive statistical graphics.
* [Basemap](http://basemaptutorial.readthedocs.io/en/latest/index.html): Great tool for creating maps using python in a simple way.
* [Bokeh](http://bokeh.pydata.org/en/latest/): Brings D3- style visualization into Python.
* [D3](http://d3js.org/): Sophisticated interactive visualizations for the web (however not for python).
* [ggplot](http://ggplot.yhathq.com/): Python port of the popular R library *ggplot2*.
* [Chaco and Mayavi](http://code.enthought.com/projects/chaco/): It works well for interactive data visualization and exploration (2D and 3D).
* [Lightning](http://lightning-viz.org/): Provides API-based access to reproducible web visualizations.

### Flask

* [Flask Frozen](https://nicolas.perriault.net/code/2012/dead-easy-yet-powerful-static-website-generator-with-flask/): powerful static website generator 
* [Flask Tutorial](http://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-ii-templates): Web applications in Python using the Flask 
* [Web App](http://code.tutsplus.com/tutorials/creating-a-web-app-from-scratch-using-python-flask-and-mysql-part-3--cms-23120): Creating a Web App From Scratch Using Python Flask and MySQL
* X - [Flask-SqLAlchemy](http://flask-sqlalchemy.pocoo.org/2.1/)


### APIs
* [Python for beginners](http://www.pythonforbeginners.com/api/list-of-python-apis)
* [Python API](http://www.pythonapi.com/)
* [Programmable Web](http://www.programmableweb.com/)
* [Twython](https://twython.readthedocs.org/en/latest/)
* [GeoJSON](http://geojson.org/): GeoJSON is a format for encoding a variety of geographic data structures.
* [REST](http://rest.elkstein.org/2008/02/real-rest-examples.html): REST is an architecture style for designing networked applications.


### Miscellaneous
* [Enaml](http://nucleic.github.io/enaml/docs/): For creating professional quality user interfaces with minimal effort.
* [PyQwt](http://pyqwt.sourceforge.net/): It provides a widget to plot 2-dimensional data.
* [Binder](http://mybinder.org/): Turn a GitHub repo into a collection of interactive notebooks.
* [Searchcode](https://searchcode.com/): Google for coding.
* [Virtual Enviroment](https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda/): Create virtual environments for python with conda.
* [Jinja2](http://jinja.pocoo.org/docs/dev/templates/#builtin-filters): Template Designer Documentation
* [Bootstrap](getbootstrap.com/css/): Global CSS settings



----
----


### * Webpages worthwhile reading

* [Machine Learning Projects](http://www.kdnuggets.com/2016/06/five-more-machine-learning-projects-cant-overlook.html#.V3KHYJWh9Sg.facebook): 5 Machine Learning Projects You Can No Longer Overlook.
* [Data Science](http://p.migdal.pl/2016/03/15/data-science-intro-for-math-phys-background.html): Data science intro for math/phys background.
* [30 Articles](http://www.kdnuggets.com/2015/09/30-hbr-articles-analytics-big-data-science.html): 30 Can’t miss Review articles on Data Science, Big Data and Analytics.
* [Preparing for Insight](http://insightdatascience.com/blog/preparing_for_insight.html): Data Science Resources from Insight Data Science.
* [Coding Bootcamps](http://www.skilledup.com/articles/coding-bootcamps-new-york): The Complete Guide To Coding Bootcamps in New York.
* [Data analyst](https://www.udacity.com/career-paths/data-analyst): Become a Data Analyst, A Beginner's Guide.
* [Data Science](http://learnds.com/): Open content for self-directed learning in data science.
* [Data Science Masters](http://datasciencemasters.org/): The Open Source Data Science Masters.
* [Data quest](https://www.dataquest.io/path/data-scientist): Becoming a Data Scientist.
* [Data Science is cool](http://will-stanton.com/how-do-i-get-my-first-job-in-data-science/): How do I get my first job in data science? 
* [Quant](http://www.academicinvest.com/science-careers/mathematics-careers/how-to-become-a-quantitative-analyst): How to Become a Quantitative Analyst.
* [Sport of Data Science](http://blog.kaggle.com/2011/03/23/getting-in-shape-for-the-sport-of-data-sciencetalk-by-jeremy-howard/): Getting In Shape For The Sport Of Data Science.
* [Programming](https://www.quora.com/What-are-the-best-programming-bootcamps-courses-available-in-the-United-States): What are the best programming bootcamps/courses available in US




------
-----