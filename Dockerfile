FROM haskell:8

MAINTAINER Karl Benedict <kbene@unm.edu>
# forked from jagregory/pandoc-docker

# install latex packages
RUN apt-get update -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    texlive-latex-base \
    texlive-xetex latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-bibtex-extra \
    fontconfig \
    lmodern \
    cm-super

# will ease up the update process
# updating this env variable will trigger the automatic build of the Docker image
# ENV PANDOC_VERSION "1.19.2.1"

# install pandoc
RUN cabal update && cabal install pandoc pandoc-citeproc

WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]
