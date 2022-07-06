FROM rocker/tidyverse:latest

#WORKDIR /home/rstudio
ARG workpath=/home/rstudio
RUN apt update && \
  apt install -y libudunits2-dev libproj-dev libgdal-dev libjq-dev ghostscript \
  texlive-extra-utils

RUN groupadd -g 1002 host
RUN usermod -a -G 1002 rstudio

USER rstudio
COPY --chown=rstudio setup_pkg.R ${workpath}/
COPY --chown=rstudio diff.csv ${workpath}
RUN /usr/local/bin/Rscript ${workpath}/setup_pkg.R && \
  rm ${workpath}/diff.csv ${workpath}/setup_pkg.R
RUN ${workpath}/bin/tlmgr install babel-italian && \
  ${workpath}/bin/tlmgr install grfext && \
  ${workpath}/bin/tlmgr install hyphen-italian && \
  ${workpath}/bin/tlmgr install changepage &&  \
  ${workpath}/bin/tlmgr install ifmtarg && \
  ${workpath}/bin/tlmgr install paralist && \
  ${workpath}/bin/tlmgr install placeins && \
  ${workpath}/bin/tlmgr install sauerj  && \
  ${workpath}/bin/tlmgr install tufte-latex && \
  ${workpath}/bin/tlmgr install xifthen  && \
  ${workpath}/bin/tlmgr install hardwrap && \
  ${workpath}/bin/tlmgr install metalogo && \
  ${workpath}/bin/tlmgr install xltxtra && \
  ${workpath}/bin/tlmgr install realscripts && \
  ${workpath}/bin/tlmgr install titlesec && \
  ${workpath}/bin/tlmgr install ragged2e&& \
  ${workpath}/bin/tlmgr install textcase && \
  ${workpath}/bin/tlmgr install setspace && \
  ${workpath}/bin/tlmgr install fancyhdr && \
  ${workpath}/bin/tlmgr install units && \
  ${workpath}/bin/tlmgr install ulem && \
  ${workpath}/bin/tlmgr install morefloats && \
  ${workpath}/bin/tlmgr install wasysym
COPY --chown=rstudio make_pdf.R ${workpath}/

USER root
RUN rm -rf /var/lib/apt/lists/*
ENV PATH="${workpath}/bin:${PATH}"


ENTRYPOINT ["/home/rstudio/make_pdf.R"]