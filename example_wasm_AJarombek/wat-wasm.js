/**
 * Run the Web Assembly function
 * @author Andrew Jarombek
 * @since 12/30/2018
 */

const wabt = require("wabt")();
const fs = require("fs");

/**
 * Convert a web assembly text file (.wat) to a web assembly binary file (.wasm)
 * @param inputWat - the name of the existing .wat file
 * @param outputWasm - the name of the produced .wasm file
 */
const watToBinary = (inputWat, outputWasm) => {
    const wasmModule = wabt.parseWat(inputWat, fs.readFileSync(inputWat, "utf8"));
    const {buffer} = wasmModule.toBinary({});

    fs.writeFileSync(outputWasm, new Buffer(buffer));
};

/**
 * Compile and run a web assembly binary
 * @param wasm - the name of the .wasm file
 * @param exec - a function that executes with an instance of the compiled web assembly program
 * @return {Promise<void>}
 */
const runWasm = async (wasm, exec) => {
    const buffer = fs.readFileSync(wasm);
    const module = await WebAssembly.compile(buffer);
    const instance = await WebAssembly.instantiate(module);

    exec(instance);
};

/**
 * Execute a web assembly text file.  Internally this function calls watToBinary() to convert the
 * .wat file to .wasm, and then calls runWasm() to compile and run the .wasm binary file.
 * @param wat - the name of the existing .wat file
 * @param exec - a function that executes with an instance of the compiled web assembly program
 */
exports.execWat = (wat, exec) => {
    const outputWasm = `${wat.substr(0, wat.indexOf('.'))}.wasm`;
    watToBinary(wat, outputWasm);
    runWasm(outputWasm, exec);
};

module.exports = exports;