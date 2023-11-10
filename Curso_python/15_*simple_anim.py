"""
==================
Animated line plot
==================

"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

fig, (ax, ax2)  = plt.subplots(2)

x = np.arange(0, 2*np.pi, 0.5)
line, = ax.plot(x, np.sin(x), 'ro-')
line2, = ax2.plot(x, np.cos(x), 'bx-')


def init():  # only required for blitting to give a clean slate.
    line.set_ydata([10.0] * len(x))
    line2.set_ydata([10.0] * len(x))
    #print [np.nan] * len(x)
    return line, line2


def animate(i):
    line.set_ydata(np.sin(x + i / 100))  # update the data.
    line2.set_ydata(np.cos(x + i / 100))
    return line, line2


ani = animation.FuncAnimation(
    fig, animate, init_func=init, interval=20, blit=True, save_count=50)
#    fig, animate, init_func=init, interval=1, blit=False, save_count=50)

#interval : number, optional
#    Delay between frames in milliseconds. Defaults to 200.




# To save the animation, use e.g.
#
#ani.save("movie.mp4")
#
# or
#
# from matplotlib.animation import FFMpegWriter
# writer = FFMpegWriter(fps=15, metadata=dict(artist='Me'), bitrate=1800)
# ani.save("movie.mp4", writer=writer)

plt.show()
