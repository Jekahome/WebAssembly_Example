const fs = require('fs');
const wabt = require('wabt')();

async function main(){
    const src = './0.wat';
    const wasm = wabt.parseWat(src,fs.readFileSync(src,'utf8'));
    const {buffer} = wasm.toBinary({});
    const {instance} = await WebAssembly.instantiate(buffer);
    const {exports: e} = instance;

    console.log('f01_const',e.f01_const());
}

//console.clear();
main().catch(e =>{
    console.error(e);
    process.exit(1);
});



