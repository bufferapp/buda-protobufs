const assert = require('assert')
const protobufjs = require('protobufjs')
const buda = require('./index')

// Very basic test to check that messages and services are loaded correctly
assert.ok(Object.keys(buda).length > 0)
assert.ok(buda.EventsCollector)

// Test some message types
assert.ok(buda.Uuid)
assert.ok(buda.Signup)
assert.ok(buda.Visit)

console.log('Test passed')
