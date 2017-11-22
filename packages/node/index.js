const path = require('path')
const grpc = require('grpc')
const protobuf = require('protobufjs')
const PROTO_PATH = path.join(__dirname, 'buda.proto')
const root = protobuf.loadSync(PROTO_PATH)
const protos = grpc.loadObject(root)

const buda = Object.assign({}, root.nested.buda.nested, {
  EventsCollector: protos.buda.EventsCollector,
  credentials: grpc.credentials.createInsecure(),
  grpc : grpc
})

module.exports = buda
