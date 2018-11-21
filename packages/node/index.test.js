const assert = require('assert')
const { EventsCollector, Visit, credentials } = require('./index')

// Very basic test to check that messages and services are loaded correctly
assert.ok(EventsCollector)
assert.ok(credentials)
assert.ok(Visit)

const client = new EventsCollector('localhost:50051', credentials)
assert.ok(client.CollectVisit)

console.log('Test passed')
