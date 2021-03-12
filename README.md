# NativeScript Task Dispatcher for Reliable Android Task Scheduling


This repository is the reproducibility package for the article “Using mobile Devices as Scientific Measurement Instruments: Reliable Android Task Scheduling". In terms of software, the paper provides to main outputs. The first and most important is the **NativeScript Task Dispatcher** library, see [https://github.com/GeoTecINIT/nativescript-task-dispatcher](https://github.com/GeoTecINIT/nativescript-task-dispatcher) ([10.5281/zenodo.4530103](https://doi.org/10.5281/zenodo.4530103)). The second is the analysis and results of one of the experiments reported in the article (*Experiment 1: simple task scheduling*), which is the focus of this repository.

## Reproduce online

## Reproduce localli with Docker

## Files in this repository

- `data-raw/*.csv`. Each file corresponds to the raw data collected during 2 weeks per type of device and scheduling application.
- `data/data_ieeetmc.{csv,rds}`: Processed data ready for analysis that integrates all raw datasets.
- `ntd-experiment1.Rmd`: R Markdown document with the analysis and visualisation of the *Experiment 1: simple task scheduling*.
- `figs/fig_boxplot.png`: figure created by the analysis `ntd-experiment1.Rmd` and is part of the submitted article (Fig 4).
- `Dockerfile`: A recipe for the computational environment using [Docker](https://en.wikipedia.org/wiki/Docker_(software)).
- `install.R`: R script file executed during creation of the Docker image to install required dependencies.

## Licence

The documents in this repository are licensed under [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

All contained code is licensed under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/).

The data used is licensed under [Open Data Commons Attribution License](https://opendatacommons.org/licenses/by/).