# NativeScript Task Dispatcher for Reliable Android Task Scheduling


This repository is the reproducibility package for the article “Using mobile Devices as Scientific Measurement Instruments: Reliable Android Task Scheduling". In terms of software, the paper provides two main outputs. The first and most important is the **NativeScript Task Dispatcher** library, see [https://github.com/GeoTecINIT/nativescript-task-dispatcher](https://github.com/GeoTecINIT/nativescript-task-dispatcher) ([10.5281/zenodo.4530103](https://doi.org/10.5281/zenodo.4530103)). The second is the analysis and results of one of the experiments reported in the article (*Experiment 1: simple task scheduling*), which is the focus of this repository.


<!--
[![Article DOI](https://img.shields.io/badge/PUBLISHER-https%3A%2F%2Fdoi.org%2FDOI-brightgreen.svg)](https://doi.org/)
[![Earth ArXiv Preprint
DOI](https://img.shields.io/badge/%F0%9F%8C%8D%F0%9F%8C%8F%F0%9F%8C%8E%20EarthArXiv-doi.org%2F10.31223%2FX5ZK5V-%23FF7F2A)](https://doi.org/10.31223/X5ZK5V)
[![Zenodo
DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4032875.svg)](https://doi.org/10.5281/zenodo.4032875)
-->

## Reproduce online

Click the “Binder” button below to open an interactive editing environment with all required software installed on
[MyBinder.org](https://mybinder.org/). It uses the current version of the branch `master` in the repository, but you can also enter the Zenodo DOI (see above) in the MyBinder user interface to open a preserved release version.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/GeoTecINIT/nativescript-ieeetmc-journal/main?urlpath=rstudio)

You can start RStudio for the analysis via “New \> RStudio”. You can navigate to the R Markdown notebook file (see [list of files below](#files-in-this-repository)) to inspect and reproduce the table and figure as described in [Reproduce analysis](#reproduce-analysis), except that local installation of required packages is not required.

## Reproduce analysis


## Reproduce locally with Docker

## Files in this repository

- `data-raw/*.csv`. Each file corresponds to the raw data collected during 2 weeks per type of device and scheduling application.
- `data/data_ieeetmc.{csv,rds}`: Processed data ready for analysis that integrates all raw datasets.
- `data/devices.csv`: List of Android-based mobile devices used for experimentation.
- `ntd-experiment1.Rmd`: R Markdown document with the analysis and visualisation of the *Experiment 1: simple task scheduling*.
- `figs/fig_boxplot.png`: figure created by the analysis `ntd-experiment1.Rmd` and is part of the submitted article (Fig 4).
- `Dockerfile`: A recipe for the computational environment using [Docker](https://en.wikipedia.org/wiki/Docker_(software)).
- `install.R`: R script file executed during creation of the Docker image to install required dependencies.

## Licence

The documents in this repository are licensed under [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

All contained code is licensed under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/).

The data used is licensed under [Open Data Commons Attribution License](https://opendatacommons.org/licenses/by/).