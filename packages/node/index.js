const path = require('path')
const grpc = require('grpc')
const protobuf = require('protobufjs')
const PROTO_PATH = path.join(__dirname, '../../buda/events_collector_service.proto')
const root = protobuf.loadSync(PROTO_PATH)
const protos = grpc.loadObject(root)

const buda = Object.assign({}, root.nested.buda, {
  EventsCollector: protos.buda.EventsCollector
})

module.exports = buda
