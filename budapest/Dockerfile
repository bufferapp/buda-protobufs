FROM python:3.6-alpine
RUN pip install protobuf
FROM znly/protoc
COPY --from=0 / /
ENTRYPOINT []
