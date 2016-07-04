# The Python compendium

This folder contains several scripts, notes and examples collected through many nights of 
coding (hopefully they'll be useful in future references). 
**N.B.** highly encouraged to recycle and make use of them in any possible way.
More elaborated examples may be found in the astro/cosmo folders. 

As you can see below, Python is the dominant language, however
due to the popularity of R I have added some standard notes, visualizations
and basic statistic examples.
There are also couple of SQL examples, based on SQLite and MYSQL. 


The majority of the content may be found spread around the web or throughout books, but 
the bibliography I used, and possibly where all the info is coming from, 
is displayed on the bottom of the page.

x - means that I haven't had a chance to spend a considerable amount of time in that particular topic.

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


### Working with data 

* [Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/Pandas.ipynb) 
* [Writing and Reading files](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/Input_output.ipynb): Basic reading/writing csv files, and plotting with pandas.
* [Writing and Reading files II](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/Input_output_II.ipynb): Working with JSON, HDF5, XLS.
* [Data Analysis with Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/Data_Analysis_with_Pandas.ipynb): Examples: stocks, baby names, elections.
* [IPython Notebook & Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Working_data/IPythonNB_Pandas.ipynb): Correlation between people cycling and weather in Montreal. 

### SQL

* [Interacting with databases (SQLite3)](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/SQL/Interacting_with_databases.ipynb): IPython notebook and Pandas connecting with SQLite.
* [MySQL basics](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_Filtering.sql) - : Basic scripts to write SQL language. 
* [Queries](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_Queries.sql) - 
[Filtering](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_Filtering.sql) - 
[Multiple tables](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_multiple_tables.sql): Some examples on a database.	 
* [MySQL Sets](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/SQL_sets.sql): Working with sets.
* [MySQL DBs](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/TSQL_Example.sql) - 
[Countries](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/TSQL_countries.sql) - 
[Person](https://github.com/ja-vazquez/Python_compendium/blob/master/SQL/TSQL_person.sql). Some tables to practice over examples.



###Visualizations

* [Basics of Matplotlib and pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Visualization/Visualizing_Data.ipynb):
General Matplotlib intro, and some examples with pandas.
* [Pandas and Basemap](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Visualization/Pandas_Basemap.ipynb):
Visualizing maps.
* [Plotting with Bokeh](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Visualization/Bokeh_examples.ipynb):
	Map of NY Unemployment.
* [Constraints](http://nbviewer.jupyter.org/github/ja-vazquez/BOSS_files/blob/master/DR12/dr12_constraints.ipynb), [Getdist](http://getdist.readthedocs.org/en/latest/plot_gallery.html): Given MCMC chains, we're able to produce constraint plots.	 
* x - [D3 Turorials](https://github.com/mbostock/d3/wiki/Tutorials)
* x - [Cartobd](http://docs.cartodb.com/tutorials/named_maps/)




### R

* [R and other languages](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Compiled_C_F/other_lang.R): Working 	with C/C++/Fortran/Python.
* [The basics](https://github.com/ja-vazquez/Python_compendium/blob/master/R/The_basics.R): Vectors, Matrices, Data Frames,
	Stats, Probability Distributions.
* [Descriptive Stats](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Descriptive_statistics.R): Descriptive
	Statistics and Exploratory Analysis. Data Visualization. Statistical Inference.
* [Regression](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Regression.R): Linear Regression, Confidence
	Ellipses and Bands. Polynomial regression. Non-linear Regression.
* [Bootstrapping](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Bootstrapping.R): Parametric and Nonparametric
	Bootstrapping. 
* [Model Selection](https://github.com/ja-vazquez/Python_compendium/blob/master/R/Model_selection.R): AIC and BIC, R^2.
* [Gaussian, Bernoulli, Count models](): Fitting curves with JAGS


### Machine Learning, Stats and other magic tricks

* [Inverse problems](http://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/ML/inverse_problems.ipynb): Linear Regression, Gradient Descent.
* [Sparcity](http://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/ML/sparcity.ipynb): FFT, Denoising functions.
* [Wavelets](http://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/ML/wavelets.ipynb): Discrete Fourier Transform, Multiresolution Analysis.



### Parallel Computing

* [Multiprocessing](https://github.com/ja-vazquez/Python_compendium/tree/master/multiprocessing). Plot a bunch of SDSS spectra in parallel via multiprocessing.
* [MPI with IPython](https://github.com/ipython/ipyparallel) and 
  [mpi4py](http://nbviewer.jupyter.org/github/ja-vazquez/GM_Sampler/blob/master/GM/Mpi4y.ipynb) used to parallelize 
  [The GM-Sampler](https://github.com/ja-vazquez/GM_Sampler/blob/master/GM/game.py).
* [Example](http://nbviewer.jupyter.org/github/ja-vazquez/GM_Sampler/blob/master/GM/GMSampler.ipynb): one of 
	the outcomes that uses a unimodal Gaussian likelihood. 





----
------
------


# Bibliography

* [IPython tutorial](https://ipython.org/ipython-doc/2/interactive/tutorial.html)
* [Python for Data Analysis](http://www.amazon.com/Python-Data-Analysis-Wrangling-IPython/dp/1449319793)



### Data scraping 
		 
* [Beatiful Soup](https://www.crummy.com/software/BeautifulSoup/):
Python library designed for quick turnaround projects like screen-scraping.
* [Scrapy](http://doc.scrapy.org/en/master/intro/tutorial.html):
For building more complicated web-scrapers.
* [Requests](http://docs.python-requests.org/en/master/):
* [html5lib](https://pypi.python.org/pypi/html5lib):


### Data wrangling

* [Pandas](http://pandas.pydata.org/):
Provides high-performance, easy-to-use data structures and data analysis tools.
* [Pandas Cookbook](https://github.com/jvns/pandas-cookbook) Gives concrete examples for getting started with pandas.

### Statistics and Probability

* [Scipy](http://www.scipy.org/):
SciPy is a Python-based ecosystem of open-source software for mathematics, science, and engineering.
* [Statsmodels](http://statsmodels.sourceforge.net/devel/index.html):
Provides classes and functions for the estimation of many different statistical models.

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
* [Seaborn](http://stanford.edu/~mwaskom/software/seaborn/):
It provides a high-level interface for drawing attractive statistical graphics.
* [Basemap](http://basemaptutorial.readthedocs.io/en/latest/index.html): Great tool for creating maps using python in a simple way.
* [Bokeh](http://bokeh.pydata.org/en/latest/):
Brings D3- style visualization into Python.
* [D3.js](http://d3js.org/):
Sophisticated interactive visualizations for the web (however not for python).
* [ggplot](http://ggplot.yhathq.com/):
Python port of the popular R library *ggplot2*.
* [Chaco and Mayavi](http://code.enthought.com/projects/chaco/): It works well for interactive data visualization and exploration (2D and 3D).

### Flask

* X - [Web App](http://code.tutsplus.com/tutorials/creating-a-web-app-from-scratch-using-python-flask-and-mysql-part-3--cms-23120)
* X - [Tutorial](http://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-ii-templates)
* X - [Flack-SqLAlchemy](http://flask-sqlalchemy.pocoo.org/2.1/)

### APIs
* [Python for beginners](http://www.pythonforbeginners.com/api/list-of-python-apis)
* [Python API](http://www.pythonapi.com/)
* [Programmable Web](http://www.programmableweb.com/)
* [Twython](https://twython.readthedocs.org/en/latest/)
* [GeoJSON](http://geojson.org/): 
GeoJSON is a format for encoding a variety of geographic data structures.
* [REST](http://rest.elkstein.org/2008/02/real-rest-examples.html):
REST is an architecture style for designing networked applications.

### Miscellaneous
* [Enaml](http://nucleic.github.io/enaml/docs/): For creating professional quality user interfaces with minimal effort.
* [PyQwt](http://pyqwt.sourceforge.net/): It provides a widget to plot 2-dimensional data.


----
----
