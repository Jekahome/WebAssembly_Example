const {execWat} = require('./wat-wasm');

// Basic addition operation in Web Assembly
execWat("wa/test.wat", (instance) => console.info(instance.exports.add(2, 2)));