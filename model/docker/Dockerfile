FROM continuumio/anaconda3

RUN conda install jupyter -y --quiet && \
    conda install -c conda-forge scikit-surprise && \
    mkdir -p opt/notebooks && \
    rm -rf /var/lib/apt/lists/*

# pip install \
#     calplot \

EXPOSE 8888

WORKDIR /opt

COPY /docker-cmd.sh .

CMD [ "/opt/docker-cmd.sh" ]
