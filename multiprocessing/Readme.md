# Tips and tricks for accelerating python code

## python multiprocessing module

`plot_sdss_spectrum.py` (run with '-h' for usage help) is an example for how to use the multiprocessing module to plot many SDSS spectra in parallel. The results on my laptop (2 real cores, 4 "virtual" Hyperthreaded cores) are shown below. That's about a 2x speedup when using all 4 virtual cores, which is pretty good, considering there's also disk IO involved. There's probably room to make this faster too, though some of it may be limited by matplotlib itself.

```
$ time ./plot_sdss_spectra.py spectra/spec-0677-52606-05*
real    0m22.561s
user    0m21.908s
sys 0m0.543s

$ time ./plot_sdss_spectra.py -mp -p 2 spectra/spec-0677-52606-05*

real    0m15.144s
user    0m28.392s
sys 0m0.782s

$ time ./plot_sdss_spectra.py -mp -p 4 spectra/spec-0677-52606-05*

real    0m12.827s
user    0m39.254s
sys 0m1.077s
```

Run the code with `python -m cProfile -o plotspec.prof plot_sdss_spectrum.py ...` to get a dump of the profiling information. Load and print the profiling data with:
```
import pstats
stats = pstats.Stats('plotspec.prof')
stats.strip_dirs()
stats.sort_stats('cumtime').print_stats(20)
```
See the python profiling page for more on working with pstats data:

https://docs.python.org/2/library/profile.html

### numbapro

Install via anaconda:

https://store.continuum.io/cshop/academicanaconda

and click the "Free" button next to "Anaconda Academic License" in the upper-right. Put in your contact information, and be sure to use your .edu email address. You will receive an email (possibly immediately) with your academic license and instructions, the gist of which are:

Copy the license file attached to the email into ~/.continuum/
  conda update conda
  conda install accelerate
  conda install iopro

To see if it worked, running the following in a python instance should produce no errors:

```
import numpy as np
from numbapro import vectorize
@vectorize(['float64(float64, float64)'], target='parallel')
def sum(a, b):
   return a + b

N = 10000
xx = np.random.random(N)
yy = np.random.random(N)
sum(xx,yy)
```

#### CUDA for GPU acceleration

To use the 'gpu' vectorize target, you have to install the CUDA drivers and libraries from NVIDA (and have a compatible NVIDIA GPU). Continuum.io has instructions on their website:

http://docs.continuum.io/numbapro/install.html#cuda-gpus-setup

Which essentially involve installing the CUDA toolkit and drivers from here:

https://developer.nvidia.com/cuda-toolkit

Afterwhich, this should give you some useful output (if everything worked and you have a valid GPU):

```
import numbapro
numbapro.check_cuda()
```

