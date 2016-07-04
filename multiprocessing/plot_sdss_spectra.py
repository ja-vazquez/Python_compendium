#!/usr/bin/env python
"""
Plot a bunch of SDSS spectra in parallel via multiprocessing.

Plots are saved into: plots/

To get some data to plot, find a random plate number:
    http://api.sdss3.org/randomPlate
Put that plate number (and a restriction on object class/redshift/whatever):
    http://data.sdss3.org/advancedSearch
Select a bunch of rows (or just click All if you want a lot of files), and
follow the wget instructions in the window that appears to download the files
to the directory of your choice.
"""
import multiprocessing

import matplotlib

import SDSSSpec

def plot_file(file):
    """Make a plot from a spectrum file."""
    spec = SDSSSpec.Spectrum(file)
    spec.plot(savedir='plots')

def plot_files(files,interactive=False):
    """Make a plot from each file, and wait for input before the next."""
    for file in files:
        plot_file(file)
        if interactive:
            raw_input('Press enter to continue...')

def main():
    import argparse
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('files',metavar='FILES',type=str,nargs='+',
                        help='SDSS spectrum FITS files to open')
    parser.add_argument('--interactive', '-i', dest='interactive', action='store_true',
                        help='Make plots in interactive mode.')
    parser.add_argument('-mp', dest='multiprocessing', action='store_true',
                        help='Do the work via multiprocessing.map().')
    parser.add_argument('-p', dest='processes', type=int, default=multiprocessing.cpu_count(),
                        help='Number of processes to plot with (default: #CPU cores)')
    args = parser.parse_args()

    if not args.interactive:
        matplotlib.use('Agg')
    else:
        # NOTE: have to do the import here to set plt.ion(),
        # but we don't want to do it otherwise, as once plt is import, other
        # backend magic happens that we might want to tweak.
        import matplotlib.pyplot as plt
        # These are common interactive backends:
        # uncomment one if you're having trouble displaying plots.
        # matplotlib.use('macosx')
        # matplotlib.use('TkAgg')
        plt.ion()

    if args.multiprocessing:
        pool = multiprocessing.Pool(processes=args.processes)
        pool.map(plot_file, args.files)
        pool.close()
        pool.join()
    else:
        plot_files(args.files,interactive=args.interactive)

if __name__ == '__main__':
    main()
