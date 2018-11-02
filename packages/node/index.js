const path = require('path')
const protoLoader = require('@grpc/proto-loader')
const grpc = require('@grpc/grpc-js')

const packageDefinition = protoLoader.loadSync(path.join(__dirname, 'buda.proto'))
const packageObject = grpc.loadPackageDefinition(packageDefinition);

module.exports = {
  EventsCollector: packageObject.buda.EventsCollector,
  credentials: grpc.credentials.createInsecure(),
}
