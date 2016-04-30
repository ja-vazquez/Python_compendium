import shapefile

sf = shapefile.Reader("mexbdy.shp")

#print dict((d[0],d[1:]) for d in sf.fields[1:])
#{'DIP_DIR': ['N', 3, 0], 'DIP': ['N', 2, 0], 'TYPE': ['C', 10, 0]}
fields = [field[0] for field in sf.fields[1:]]
for feature in sf.shapeRecords():
	    geom = feature.shape.__geo_interface__
	    atr = dict(zip(fields, feature.record))
	    if atr['DESCRIP'] == 'CHIAPAS' or atr['POLYID'] == 39:
		    print geom['coordinates'][0]


shapes = sf.shapes()
shape = shapes[37].points[:]
#print shape

