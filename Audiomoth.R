# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Frankee Humanity Project:
# The aim of this script if to draw spectograms from Audiomoths and detect bird calls
# diego.ellissoto@yale.edu
# Diego Ellis Soto, Yale University, Department of Ecology and Evolutionary Biology
#
# 
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# https://github.com/ChristopherCarignan/audio2stl
# https://github.com/nwolek/audiomoth-scripts # make a spectogram in bash ####

bash rename-by-date.sh *.WAV
bash make-spectrogram-image.sh 5EC5A*.WAV
bash make-spectrogram-movie.sh 2020-06-01-*.wav
bash make-spectrogram-movie.sh 2020-05-20-22-*.wav
bash make-html-table.sh *.wav
open index.html
bash make-html-lightbox-table.sh *.wav
open index.html

# R packages for sound scape analysis ####
# https://marce10.github.io/2017/06/06/Individual_sound_files_for_each_selection.html
# Raven by Cornell https://marce10.github.io/Rraven/
# https://marce10.github.io/dynaSpec/ # Very cool check out
# http://rug.mnhn.fr/seewave/ # very cool check out


# Warbker code following here: https://mran.microsoft.com/snapshot/2017-12-15/web/packages/warbleR/vignettes/warbleR_workflow_phase1.html

library(warbleR)
setwd('/Users/diegoellis/Downloads/drive-download-20210311T225346Z-001/')
list.files()
wavs <- list.files('/Users/diegoellis/Downloads/drive-download-20210311T225346Z-001/', pattern=".WAV")

# We will use this list to downsample the wav files so the following analyses go a bit faster
lapply(wavs, function(x) writeWave(downsample(readWave(x), samp.rate = 22050),filename = x))


# Let's first create a subset for playing with arguments 
# This subset is based on the list of wav files we created above
sub <- wavs[c(1,3)]

# ovlp = 10 speeds up process a bit 
# tiff image files are better quality and are faster to produce
lspec(flist = sub, ovlp = 10, it = "tiff")

# We can zoom in on the frequency axis by changing flim, 
# the number of seconds per row, and number of rows
lspec(flist = sub, flim = c(1.5, 11), sxrow = 6, rows = 15, ovlp = 10, it = "tiff")
# Once satisfied with the argument settings we can run all files

lspec(flim = c(1.5, 11), ovlp = 10, sxrow = 6, rows = 15, it = "tiff")
lspec(flim = c(2, 10), ovlp = 10, sxrow = 6, rows = 15, it = "jpeg")

# concatenate lspec image files into a single PDF per recording
# lspec images must be jpegs 
lspec2pdf(keep.img = FALSE, overwrite = TRUE)

# https://mran.microsoft.com/snapshot/2017-12-15/web/packages/warbleR/vignettes/warbleR_workflow_phase1.html


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

library(warbleR)
setwd('/Users/diegoellis/Downloads/Audiomoth_neat/')
list.files()
wavs <- list.files('/Users/diegoellis/Downloads/Audiomoth_neat/', pattern=".WAV")

# We will use this list to downsample the wav files so the following analyses go a bit faster
lapply(wavs, function(x) writeWave(downsample(readWave(x), samp.rate = 22050),filename = x))


# Let's first create a subset for playing with arguments 
# This subset is based on the list of wav files we created above
sub <- wavs[c(1,3)]

# ovlp = 10 speeds up process a bit 
# tiff image files are better quality and are faster to produce
lspec(flist = sub, ovlp = 10, it = "tiff")

# We can zoom in on the frequency axis by changing flim, 
# the number of seconds per row, and number of rows
lspec(flist = sub, flim = c(1.5, 11), sxrow = 6, rows = 15, ovlp = 10, it = "tiff")
# Once satisfied with the argument settings we can run all files

lspec(flim = c(1.5, 11), ovlp = 10, sxrow = 6, rows = 15, it = "tiff")
lspec(flim = c(2, 10), ovlp = 10, sxrow = 6, rows = 15, it = "jpeg")

# concatenate lspec image files into a single PDF per recording
# lspec images must be jpegs 
lspec2pdf(keep.img = FALSE, overwrite = TRUE)

# https://mran.microsoft.com/snapshot/2017-12-15/web/packages/warbleR/vignettes/warbleR_workflow_phase1.html


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Plot a spectrogram:
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
require(seewave)
library(tuneR)

audio_moth_1<-readWave("/Users/diegoellis/Downloads/Audiomoth_neat/20210228_122200.WAV")
audio_moth_1<-readWave("/Users/diegoellis/Desktop/Trim_audiomoth.wav")

spectro3D(audio_moth_1, wl=1000, ovlp=85, zp=6, maga=8, palette=spectro.colors)

spectro3D(audio_moth_1, wl=100, palette=spectro.colors)

#load package
library(dynaSpec)

# and load other dependencies
library(viridis)
library(tuneR)
library(seewave)
library(warbleR)



scrolling_spectro(wave = audio_moth_1, wl = 300, 
                  t.display = 180, pal = viridis, 
                  grid = FALSE, 
                  width = 1000, height = 500, 
                  res = 120, file.name = "default.mp4")


scrolling_spectro(wave = audio_moth_1, wl = 300, 
                  t.display = 1.7, pal = viridis, 
                  grid = FALSE, flim = c(1, 9), 
                  width = 1000, height = 500, res = 120, 
                  file.name = "slow.mp4", colbg = "black",
                  speed = 0.5, osc = TRUE, 
                  colwave = "#31688E99")


scrolling_spectro(wave = audio_moth_1, wl = 300, 
                  t.display = 1.7, ovlp = 90, pal = magma, 
                  grid = FALSE, flim = c(1, 10), width = 1000, 
                  height = 500, res = 120, collevels = seq(-50, 0, 5), 
                  file.name = "no_axis.mp4", colbg = "black", 
                  speed = 0.2, axis.type = "none", loop = 3, fastdisp=TRUE)


library(phonTools)
# So first off, phonTools already has a spectrogram function that can plot the data as is.

spectrogram(audio_moth_1)

# https://joeystanley.com/blog/3d-vowel-plots-with-rayshader



data("canyon_wren")


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Spectrpgram
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
require(av)

# Calculate the frequency data and plot the spectrogram:
  
  
  # Demo sound included with av
wonderland <- system.file('samples/Synapsis-Wonderland.mp3', package='av')
fft_data <- read_audio_fft(wonderland, end_time = 5.0)
# Create new audio file with first 5 sec
av_audio_convert(wonderland, 'short.mp3', total_time = 5)
#> [1] "short.mp3"
av_spectrogram_video('short.mp3', output = 'spectrogram.mp4', width = 1280, height = 720, res = 144)

# Read first 5 sec of demo
fft_data <- read_audio_fft('/Users/diegoellis/Desktop/Trim_audiomoth.wav', end_time = 5.0)
plot(fft_data)
plot(fft_data, dark = FALSE)

# Create new audio file with first 5 sec
av_audio_convert('/Users/diegoellis/Desktop/Trim_audiomoth.wav', 'short.mp3', total_time = 5)
#> [1] "short.mp3"
av_spectrogram_video('short.mp3', output = '/Users/diegoellis/Desktop/audiomoth_spectrogram.mp4', width = 1280, height = 720, res = 144)
