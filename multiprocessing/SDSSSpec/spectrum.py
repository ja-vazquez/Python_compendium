"""Handle an SDSS Spectrum in an object-oriented manner."""

import os
import astropy.io.fits as pyfits

class Spectrum(object):
    """
    A single SDSS Spectrum, read from a spec-PLATE-MJD-FIBER.fits file.
    See the datamodel for details about the file:
        http://data.sdss3.org/datamodel/files/BOSS_SPECTRO_REDUX/RUN2D/spectra/PLATE4/spec.html
    """
    def __init__(self,filepath):
        self.filepath = filepath
        self.data = pyfits.open(filepath)
        self.basename = os.path.splitext(os.path.basename(filepath))[0]
        junk,self.plate,self.mjd,self.fiber = self.basename.split('-')

    @property
    def wavelength(self):
        """Wavelength binning, linear bins."""
        if getattr(self,'_wavelength',None) is None:
            self._wavelength = 10**self.data[1].data['loglam']
        return self._wavelength

    @property
    def flux(self):
        if getattr(self,'_flux',None) is None:
            self._flux = self.data[1].data['flux']
        return self._flux

    @property
    def error(self):
        if getattr(self,'_error',None) is None:
            self._error = 1/self.data[1].data['ivar']
        return self._error

    @property
    def sky(self):
        if getattr(self,'_sky',None) is None:
            self._sky = self.data[1].data['sky']
        return self._sky

    @property
    def model(self):
        if getattr(self,'_model',None) is None:
            self._model = self.data[1].data['model']
        return self._model

    def plot(self, savedir=None):
        """Create a plot using the specified matplotlib pyplot/gridspec instance."""

        # NOTE: cannot pickle matplotlib.pyplot (necessary for multiprocessing.map)
        # so we have to handle all plotting setup inside here.

        from matplotlib import gridspec
        import matplotlib.pyplot as plt
        plt.rcParams.update({'font.size':22,
                            'axes.labelsize': 20,
                            'legend.fontsize': 16,
                            'xtick.labelsize': 18,
                            'ytick.labelsize': 18,
                            'axes.linewidth':2})

        fig = plt.figure(figsize=(12,8))
        gs = gridspec.GridSpec(2, 1, height_ratios=[3, 1])
        ax0 = plt.subplot(gs[0])
        ax1 = plt.subplot(gs[1],sharex=ax0)
        plt.setp(ax0.get_xticklabels(), visible=False)

        ax0.plot(self.wavelength, self.sky, color='lightblue', lw=1, label='sky')
        ax0.plot(self.wavelength, self.flux, color='black', lw=2, label='flux')
        ax0.plot(self.wavelength, self.model, color='green', label='model')
        ax0.plot(self.wavelength, self.error, color='red', label='error')
        ax0.set_ylim(-3, self.flux.max()*1.1)
        ax0.set_xlabel('Wavelength [$\AA$]')
        ax0.set_ylabel('Flux [$10^{-17} \mathrm{ergs}\, \mathrm{s}^{-1} \mathrm{cm}^{-2} \mathrm{\AA}^{-1}$]')

        # put the legend on the right or left, depending on the height of the data.
        if self.flux[:100].mean() > self.flux[-100:].mean():
            ax0.legend(loc='upper right',labelspacing=.2)
        else:
            ax0.legend(loc='upper left',labelspacing=.2)

        ax1.axhline(0,color='grey')
        ax1.plot(self.wavelength, self.flux-self.model, color='green', label='SDSS model')
        ax1.set_ylim(-5,5)
        ax1.set_yticks(range(-4,5,2))
        ax1.set_ylabel('flux-model')

        fig.subplots_adjust(hspace=0)
        ax0.set_xlim(self.wavelength.min(), self.wavelength.max())

        plt.suptitle('plate={} mjd={} fiber={}'.format(self.plate,self.mjd,self.fiber))

        if savedir is not None:
            plt.savefig(os.path.join(savedir,self.basename+'.pdf'),bbox_inches='tight')
