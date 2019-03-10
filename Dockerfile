FROM ubuntu

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && conda config --add channels r \
    && conda config --add channels defaults \
    && conda config --add channels conda-forge \
    && conda config --add channels bioconda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH

# Overwrite this with 'CMD []' in a dependent Dockerfile
RUN conda upgrade conda
RUN conda install make
RUN conda install fastqc
RUN conda install fastx_toolkit
RUN conda install cutadapt
RUN conda install bowtie
RUN conda install tophat
RUN conda install star
RUN conda install hisat2=2.1.0
RUN conda install samtools=1.3.1
RUN conda install htseq
RUN conda install subread
RUN conda install cufflinks
RUN conda install salmon
RUN conda install bedtools
RUN conda install bedops
RUN conda install sra-tools
RUN conda install pysam
RUN conda install rseqc
RUN conda install multiqc


RUN mkdir /data /config
VOLUME ["/data", "/config"]
WORKDIR /data/

CMD ["bash"]
