# NativeScript Task Dispatcher for Reliable Android Task Scheduling


This repository is the reproducibility package for the article “Using mobile Devices as Scientific Measurement Instruments: Reliable Android Task Scheduling". In terms of software, the paper provides two main outputs. The first and most important is the **NativeScript Task Dispatcher** library, see [https://github.com/GeoTecINIT/nativescript-task-dispatcher](https://github.com/GeoTecINIT/nativescript-task-dispatcher) ([10.5281/zenodo.4530103](https://doi.org/10.5281/zenodo.4530103)). The second is the analysis and results of the two  experiments reported in the article. Code and data associated with these experiments is the focus of this repository.


<!--
[![Article DOI](https://img.shields.io/badge/PUBLISHER-https%3A%2F%2Fdoi.org%2FDOI-brightgreen.svg)](https://doi.org/)
[![Earth ArXiv Preprint
DOI](https://img.shields.io/badge/%F0%9F%8C%8D%F0%9F%8C%8F%F0%9F%8C%8E%20EarthArXiv-doi.org%2F10.31223%2FX5ZK5V-%23FF7F2A)](https://doi.org/10.31223/X5ZK5V)
[![Zenodo
DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4032875.svg)](https://doi.org/10.5281/zenodo.4032875)
-->

## Reproduce online

Click the “Binder” button below to open an interactive editing environment with all required software installed on
[MyBinder.org](https://mybinder.org/). It uses the current version of the branch `main` in the repository, but you can also enter the Zenodo DOI (see above) in the MyBinder user interface to open a preserved release version.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/GeoTecINIT/nativescript-journalpaper/main?urlpath=rstudio)

You can start RStudio for the analysis via “New \> RStudio”. You can navigate to the R Markdown notebook file (see [list of files below](#files-in-this-repository)) to inspect the code and reproduce (“Knit \> Knit to HTML”) the table and figure as described in [Reproduce analysis](#reproduce-analysis), except that local installation of required packages is not required.

## Reproduce analysis

For the first experiment (*Experiment 1: simple task scheduling*), open the R Markdown file (`ntd-experiment1.Rmd`) with RStudio. Then select “Knit > Knit to HTML” to render the web page. If you have errors rendering the HTML page, try running each chunk to locate the problem. This analysis does not convert raw datasets into processed data for the analysis - please execute the chunk `merge_datafiles` manually if necessary.

The R Markdown file does not include code to install required packages. Run the code in the file `install.R` to install all dependencies.

For the second experiment (*Experiment 2: complex task scheduling*), open the R Markdown file (`ntd-experiment2.Rmd`) with RStudio. Then select “Knit > Knit to HTML” to render the web page. If you have errors rendering the HTML page, try running each chunk to locate the problem. 

The R Markdown file does not include code to install required packages. Run the code in the file `install.R` to install all dependencies.


## Reproduce locally with Docker

Install [Docker CE](https://www.docker.com/community-edition) or a compatible tool for building an image based on a `Dockerfile` and running a container based on the image. The `Dockerfile` uses the Rocker image [`rocker/binder:3.6.3`](https://hub.docker.com/r/rocker/binder), providing R version `3.6.3` with a CRAN mirror timestamp of July 5th 2019.

Download the project files, open a command line in the root directory (where this file is), and run the commands as documented at the end of the `Dockerfile` file.

If you have [`repo2docker`](https://repo2docker.readthedocs.io), you can also run `repo2docker --image-name=rr-ntd-journalpaper .`  *The `repo2docker` option is the only way the original authors worked on the analysis to ensure the computing environment is properly managed.* 

## Files in this repository

Common files:

- `Dockerfile`: A recipe for the computational environment using [Docker](https://en.wikipedia.org/wiki/Docker_(software)).
- `install.R`: R script file executed during creation of the Docker image to install required dependencies.

Files to run *Experiment 1: simple task scheduling*:

- `exp1/data-raw/*.csv`. Each file corresponds to the raw data collected during 2 weeks per type of device and scheduling application.
- `exp1/data/data_ieeetmc.{csv,rds}`: Processed data ready for analysis that integrates all raw datasets.
- `exp1/data/devices.csv`: List of Android-based mobile devices used for experimentation.
- `ntd-experiment1.Rmd`: R Markdown document with the analysis and visualisation of the *Experiment 1: simple task scheduling*.
- `exp1/figs/fig_boxplot.png`: figure created by the analysis `ntd-experiment1.Rmd` and is part of the submitted article (Fig 4).
- `exp1/figs/fig_battery_composite.png`: figure created by the analysis `ntd-experiment1.Rmd` and is part of the submitted article (Fig 5).

Files to run *Experiment 2: complex task scheduling*

- `exp2/data-raw/*.*`. Capture data and events descriptions.
- `exp2/data/*.*`. Simulated data per device in json format
- `ntd-experiment2.Rmd`: R Markdown document with the analysis and visualisation of the *Experiment 2: complex task scheduling*.
- `exp2/figs/simulation_graph_v3.png`: figure created to show the task graph used by the data capturing tool and simulation application, and is part of the submitted article (Fig 5).


## Licence

The documents in this repository are licensed under [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

All contained code is licensed under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/).

The data used is licensed under [Open Data Commons Attribution License](https://opendatacommons.org/licenses/by/).