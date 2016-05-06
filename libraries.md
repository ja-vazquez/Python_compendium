# Libraries


#### %matplotlib inline

#### from pandas import Series, DataFrame
#### import pandas as pd
#### import numpy as np
#### import math
#### import datetime
#### import re
#### import csv
#### import sys
#### import JSON


#### from matplotlib import pyplot as plt
#### from twython import Twython


#### from collections import Counter
#### import itertools
#### import random
#### from functools import partial, reduce
#### import bisect
#### from collections import defaultdict
#### from collections import namedtuple, deque
#### from time import sleep
#### from numpy.linalg import inv, qr


#### from lxml.html import parse
#### from urllib2 import urlopen

#### from bs4 import BeautifulSoup
#### import requests

#### from pandas.io.parsers import TextParser


#### from bokeh.plotting import figure, output_notebook, show
#### from bokeh.io import output_notebook



#### import pandas.io.data as web
read stocks info from, i.e. yahoo

	all_data = {}
		for ticker in ['AAPL', 'IBM', 'MSFT', 'GOOG']:
    		all_data[ticker] = web.get_data_yahoo(ticker)


pd.options.display.max_rows = 10

pd.set_option('display.width', 5000) 

pd.set_option('display.max_columns', 60)

pd.set_option('display.mpl_style', 'default')
