# -*- coding: utf-8 -*-
"""
Created on Thu Nov 30 23:56:00 2017
Programa prueba para crear caminatas aleatorias.
Mark i.
@author: LuisOsvaldo
"""

import turtle
import random

wn = turtle.Screen()
turtlebase = turtle.Turtle()
turtle1 = turtle.Turtle()
turtle2 = turtle.Turtle()
turtle3 = turtle.Turtle()

turtle1.color("blue")
turtle1.pencolor("blue")

turtle2.color("green")
turtle2.pencolor("green")

turtle3.color("red")
turtle3.pencolor("red")

count = 0
while count <= 2000:
    turtle1.setheading(random.randint(0,180))
    turtle1.forward(random.randint(-20,20))

    turtle2.setheading(random.randint(0,180))
    turtle2.forward(random.randint(-25,25))
    
    turtle3.setheading(random.randint(0,360))
    turtle3.forward(random.randint(-20,20))
    
    count = count +1
wn.mainloop
