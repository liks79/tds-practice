# Use ECR public-repo Due to DockerHub pull rate limit
FROM public.ecr.aws/bitnami/python:3.10.0-prod

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g 999 appuser \ 
    && useradd -r -u 999 -g appuser appuser 

COPY ./app /app
RUN pip3 install -r requirements.txt --no-cache-dir
EXPOSE 5000
USER appuser
CMD flask run -h 0.0.0.0 -p 5000
