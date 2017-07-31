FROM python:3.6-alpine
RUN pip install protobuf
FROM znly/protoc
COPY --from=0 / /
RUN mkdir /work
WORKDIR /work
COPY commands/*.py protoc-wrap.sh /work/

ENTRYPOINT ["./protoc-wrap.sh"]
