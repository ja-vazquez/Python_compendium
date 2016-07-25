#  @file wavelet.py
#
#  WAVELET TRANSFORM ROUTINES
#
#  Functions for transforming
#  data. Based on work by
#  Fred Ngole.
#
#  @author Samuel Farrens
#  @version 1.0
#  @date 2015
#

import numpy as np
from os import remove
from subprocess import check_call
from datetime import datetime
from astropy.io import fits
from astropy.convolution import convolve_fft


##
#  Function rotates the input data by 180 degrees.
#
#  @param[in] data: Input data.
#
#  @return rotated data.
#
def rotate(data):

    return np.rot90(data, 2)


##
#  Function rotates each of the elements of an input data stack by 180 degrees.
#
#  @param[in] data: Input data stack.
#
#  @return rotated data stack.
#
def rotate_stack(data):

    return np.array([rotate(x) for x in data])


##
#  Function that calls mr_transform to perform a wavelet transform on the
#  input data.
#
#  @param[in] data: 2D Input array.
#  @param[in] opt: List of additonal mr_transform options.
#  @param[in] path: Path for output files.
#  @param[in] remove_files: Option to remove output files.
#
#  @return Results of wavelet transform (and mr file name).
#
def call_mr_transform(data, opt=None, path='./', remove_files=True):

    # Create a unique string using the current date and time.
    unique_string = datetime.now().strftime('%Y.%m.%d_%H.%M.%S')

    # Set the ouput file names.
    file_name = path + 'mr_temp_' + unique_string
    file_fits = file_name + '.fits'
    file_mr = file_name + '.mr'

    # Write the input data to a fits file.
    fits.writeto(file_fits, data)

    # Call mr_transform.
    if isinstance(opt, type(None)):
        check_call(['mr_transform', file_fits, file_mr])
    else:
        check_call(['mr_transform'] + opt + [file_fits, file_mr])

    # Retrieve wavelet transformed data.
    result = fits.getdata(file_mr)

    # Return the mr_transform results (and the output file names).
    if remove_files:
        remove(file_fits)
        remove(file_mr)
        return result
    else:
        return result, file_mr


##
#  Function that obatins filters from mr_transform using fake data.
#
#  @param[in] data_shape: 2D Array shape.
#  @param[in] levels: Number of wavelet levels to keep.
#  @param[in] opt: List of additonal mr_transform options.
#  @param[in] coarse: Option to output coarse scale.
#
#  @return Wavelet filters
#
def get_mr_filters(data_shape, levels=None, opt=None, coarse=False):

    # Adjust the shape of the input data.
    data_shape = np.array(data_shape)
    data_shape += data_shape % 2 - 1

    # Create fake data.
    fake_data = np.zeros(data_shape)
    fake_data[zip(data_shape / 2)] = 1

    # Call mr_transform.
    mr_filters = call_mr_transform(fake_data, opt=opt)

    # Choose filter levels to keep.
    if levels >= mr_filters.shape[0]:
        levels = mr_filters.shape[0] - 1
    elif levels <= 0:
        levels = None
    if isinstance(levels, type(None)):
        filters = mr_filters[:-1]
    else:
        filters = mr_filters[:levels]

    # Return filters
    if coarse:
        return filters, mr_filters[-1]
    else:
        return filters


##
#  Function that convolves the input data with filters obtained from
#  mr_transform.
#
#  @param[in] data: 2D Input array.
#  @param[in] filters: Wavelet filters.
#  @param[in] filter_rot: Option to rotate wavelet filters.
#
#  @return Convolved data.
#
def filter_convolve(data, filters, filter_rot=False):

    if filter_rot:
        return np.sum([convolve_fft(coef, f, boundary='wrap', crop=True)
                      for coef, f in zip(data, rotate_stack(filters))],
                      axis=0)

    else:
        return np.array([convolve_fft(data, f, boundary='wrap', crop=True)
                        for f in filters])


##
#  Function that calls mr_filter to perform a wavelet filtering on the
#  input data.
#
#  @param[in] data: 2D Input array.
#  @param[in] opt: List of additonal mr_transform options.
#  @param[in] path: Path for output files.
#  @param[in] remove_files: Option to remove output files.
#
#  @return Results of wavelet transform (and mr file name).
#
def call_mr_filter(data, opt=None, path='./', remove_files=True):

    # Create a unique string using the current date and time.
    unique_string = datetime.now().strftime('%Y.%m.%d_%H.%M.%S')

    # Set the ouput file names.
    file_name = path + 'mr_temp_' + unique_string
    file_fits = file_name + '.fits'
    file_mr = file_name + '.mr'

    # Write the input data to a fits file.
    fits.writeto(file_fits, data)

    # Call mr_transform.
    if isinstance(opt, type(None)):
        check_call(['mr_filter', file_fits, file_mr])
    else:
        check_call(['mr_filter'] + opt + [file_fits, file_mr])

    # Retrieve wavelet filtered data.
    result = fits.getdata(file_mr)

    # Return the mr_transform results (and the output file names).
    if remove_files:
        remove(file_fits)
        remove(file_mr)
        return result
    else:
        return result, file_mr
