(module
  (func $add (param $n0 i32) (param $n1 i32) (result i32)
    get_local $n0
    get_local $n1
    i32.add
  )

  (export "add" (func $add))
)