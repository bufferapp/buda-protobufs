const path = require('path')
const protoLoader = require('@grpc/proto-loader')
const grpc = require('@grpc/grpc-js')
const protobuf = require('protobufjs')

const protoPath = path.join(__dirname, 'buda.proto')
const packageDefinition = protoLoader.loadSync(protoPath)
// loads all of the message types for verification
const protobufLoader = protobuf.loadSync(protoPath)
const packageObject = grpc.loadPackageDefinition(packageDefinition)

module.exports = {
  ...protobufLoader.nested.buda.nested,
  EventsCollector: packageObject.buda.EventsCollector,
  credentials: grpc.credentials.createInsecure(),
  grpc,
}
