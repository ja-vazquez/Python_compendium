# The Python compendium

This folder contains several scripts, notes and examples collected through many nights of 
coding (hopefully they'll be useful in future references). 
**N.B.** highly encouraged to recycle and make use of them in any possible way.
More elaborated examples may be found in the astro/cosmo folders. 

The majority of the content may be found spread around the web or throughout books, but 
the bibliography I used, and possibly where all the info is coming from, 
is displayed on the bottom of the page.

------
### Python

* [The basics](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/The_basics.ipynb):
(lists, tuples, dictionaries, loops, etc).
* [The not so basics](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/The_not_so_basics.ipynb): 
(partial, map, reduce, filter, zip, decorators, etc).
* [iPython NB](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/iPython.ipynb):
(magic commands, debugger, profiling).
* [Numpy](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Numpy.ipynb): (Numerical Python)
* [Idiomatic Python](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Idiomatic_Python.ipynb):
(Transforming Code into Beautiful, Idiomatic Python).


### Getting data


* [Scraping the web](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scraping_the_web.ipynb): (Beatiful Soup, requests)
	- O'Reilly Media: Plotting books published over the 'data' subject.
	- Yellow Pages: Get info for Coffee shops in NYC.
* [Scraping the web II](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Scraping_the_web_II.ipynb): (Parse, urlopen)
	- Yahoo's finance, Options.	 Long Island Rail Road (XML)
* [Using Twython API](https://github.com/ja-vazquez/Python_compendium/blob/master/Twython_API.ipynb): 
Getting tweets with hashtag (i.e. Data).


### Working with data 

* [Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Pandas.ipynb) 
* [Writing and Reading files](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Input_output.ipynb): Basic reading/writing
csv files, and plotting with pandas.
* [Writing and Reading files II](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Input_output_II.ipynb): Working with JSON, HDF5, XLS
* [Data Analysis with Pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Data_Analysis_with_Pandas.ipynb): Examples: stocks, baby names, elections.
* [IPython Notebook & Pandas](https://github.com/ja-vazquez/Python_compendium/blob/master/IPythonNB_Pandas.ipynb): Correlation between people cycling and weather in Montreal. 



### Databases

* [Interacting with databases](https://github.com/ja-vazquez/Python_compendium/blob/master/Interacting_with_databases.ipynb): Employees-table in sqlite3.

###Visualizations

* [Basics of Matplotlib and pandas](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Visualizing_Data.ipynb):
General Matplotlib intro, and some examples with pandas.
* [Pandas and Basemap](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Pandas_Basemap.ipynb):
Visualizing maps.
* [Plotting with Bokeh](https://nbviewer.jupyter.org/github/ja-vazquez/Python_compendium/blob/master/Bokeh_examples.ipynb):
	Map of NY Unemployment.
* x - Plotly 
* x - D3
* x - [Cartobd](http://docs.cartodb.com/tutorials/named_maps/)
* x - [Getdist](http://getdist.readthedocs.org/en/latest/plot_gallery.html)

### Machine Learning

* x -




### MapReduce

* x - AWS



### Flask

* [Web App](http://code.tutsplus.com/tutorials/creating-a-web-app-from-scratch-using-python-flask-and-mysql-part-3--cms-23120)
* [Turorial](http://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-ii-templates)
* [Flack-SqLAlchemy](http://flask-sqlalchemy.pocoo.org/2.1/)

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

### Visualizations

* [Matplotlib](http://matplotlib.org/): python 2D plotting library.
* [Seaborn](http://stanford.edu/~mwaskom/software/seaborn/):
It provides a high-level interface for drawing attractive statistical graphics.
* [Basemap](http://basemaptutorial.readthedocs.io/en/latest/index.html): Great tool for creating maps using python in a simple way.
* [Bokeh](http://bokeh.pydata.org/en/latest/):
Brings D3- style visualization into Python.
* [D3.js](http://d3js.org/):
Sophisticated interactive visualizations for the web (however not for python).
* [D3 Turorials](https://github.com/mbostock/d3/wiki/Tutorials)
* [ggplot](http://ggplot.yhathq.com/):
Python port of the popular R library *ggplot2*.



### APIs
* [Python for beginners](http://www.pythonforbeginners.com/api/list-of-python-apis)
* [Python API](http://www.pythonapi.com/)
* [Programmable Web](http://www.programmableweb.com/)
* [Twython](https://twython.readthedocs.org/en/latest/)
* [GeoJSON](http://geojson.org/): 
GeoJSON is a format for encoding a variety of geographic data structures.
* [REST](http://rest.elkstein.org/2008/02/real-rest-examples.html):
REST is an architecture style for designing networked applications.


----
----
