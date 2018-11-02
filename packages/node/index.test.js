const assert = require('assert')
const { EventsCollector, credentials } = require('./index')

// Very basic test to check that messages and services are loaded correctly
assert.ok(EventsCollector)
assert.ok(credentials)

const client = new EventsCollector('localhost:50051', credentials)
assert.ok(client.CollectVisit)

console.log('Test passed')
