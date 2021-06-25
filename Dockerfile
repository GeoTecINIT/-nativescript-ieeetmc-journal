# This Dockerfile is based on the rocker/binder example Dockerfile from https://github.com/rocker-org/binder/
# R 3.6.3, which has a fixed MRAN date in the Rocker image.
FROM docker.io/rocker/binder:3.6.3

# Declares build arguments
ARG NB_USER
ARG NB_UID

USER ${NB_USER}

# Run install.R script
COPY install.R ${HOME}
RUN R --quiet -f install.R


# Export system libraries and R package versions
USER root
RUN dpkg --list > dpkg-list.txt && \
  R -q -e 'capture.output(knitr::kable(as.data.frame(installed.packages())[c("Package", "Version", "License", "Built")], format = "markdown", row.names = FALSE), file = "r-packages.md")'

# Copies all repo files into the Docker Container
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

# Become normal user again
USER ${NB_USER}


# --- Metadata ---
LABEL maintainer="carlos.granell@uji.es" \
  Name="NTD experiments in journal paper - computing environment" \
  Version="1" \
  org.opencontainers.image.created="2021-03" \
  org.opencontainers.image.authors="Carlos Granell" \
  org.opencontainers.image.url="https://github.com/GeoTecINIT/nativescript-journalpaper/blob/master/Dockerfile" \
  org.opencontainers.image.documentation="https://github.com/GeoTecINIT/nativescript-journalpaper" \
  org.label-schema.description="Reproducible workflow image (license: Apache 2.0)"


# --- Usage instructions ---
## Build the image
# $ docker build --tag rr-ntd-journalpaper .
#
## Build the image wirth jupyter-repo2docker
# $ jupyter-repo2docker --image-name=rr-ntd-journalpaper .
#
## Run the image for interactive UI
# $ docker run -it -p 8888:8888 rr-ntd-journalpaper
# Next, open a browser at http://localhost:8888 or click on the login link shown in the console.
# It will show the Jupyter start page and you can now open RStudio via the menu "New".

