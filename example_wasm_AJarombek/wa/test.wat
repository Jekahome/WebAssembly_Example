;; Create a basic Web Assembly function
;; Author: Andrew Jarombek
;; Date: 12/30/2018

(module
  ;; i32 is a 32-bit integer type.  Parameters are addressed as local variables.
  (func $add (param $n0 i32) (param $n1 i32) (result i32)

    ;; Retrieve local variables in the function corresponding to the arguments.
    ;; Each call to get_local pushes the corresponding value
    ;; onto the execution stack.
    get_local $n0
    get_local $n1

    ;; i32.add operation adds two integers together.  It pops both the values of
    ;; the execution stack, adds them together, and then pushes the result back
    ;; onto the stack.
    i32.add
  )

  ;; Export the 'add' function which can be used in JavaScript.
  (export "add" (func $add))
)
