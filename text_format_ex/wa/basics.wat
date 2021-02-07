(module
  ;; Function Type section
  (type $calcPace1a (func (param i32 i32 i32) (result i32)))
  (type $calcPace1b (func (param i32 i32 i32) (result i32)))
  (type $calcPace2 (func (param f32 i32 i32) (result f32)))
  (type $setInt (func (param i32 i32)))
  (type $setIntInverse (func (param i32 i32)))
  (type $getInt (func (param i32) (result i32)))
  (type $inc (func (result i32)))
  (type $div (func (param i32 i32 i32) (result i32)))

  ;; Global section
  (global $stored_location i32 (i32.const 26))

  ;; Memory section
  ;; This module requires one page of memory (64 KiB)
  (memory 1)

  ;; Export section
  (export "calcPace1a" (func $calcPace1a))
  (export "calcPace1b" (func $calcPace1b))
  (export "calcPace2" (func $calcPace2))
  (export "setInt" (func $setInt))
  (export "setIntInverse" (func $setInt))
  (export "getInt" (func $getInt))
  (export "inc" (func $inc))
  (export "div" (func $div))

  ;; Function Bodies section

  ;; Calculate the mile pace of an exercise.  The number of miles exercised must
  ;; be an integer.
  (func $calcPace1a (param $miles i32) (param $minutes i32)
                    (param $seconds i32) (result i32)
    get_local $minutes
    i32.const 60
    i32.mul
    get_local $seconds
    i32.add
    get_local $miles
    i32.div_s
  )

  ;; Rewritten with a nested s-expression form.
  (func $calcPace1b (param $miles i32) (param $minutes i32)
                    (param $seconds i32) (result i32)
    (i32.div_s
      (i32.add
        (i32.mul
          (get_local $minutes)
          (i32.const 60)
        )
        (get_local $seconds)
      )
      (get_local $miles)
    )
  )

  (func $calcPace2 (param $miles f32) (param $minutes i32)
                   (param $seconds i32) (result f32)
    (f32.div
      ;; Convert the 32-bit integer into a 32-bit floating point number
      (f32.convert_s/i32
        (i32.add
          (i32.mul
            (get_local $minutes)
            (i32.const 60)
          )
          (get_local $seconds)
        )
      )
      (get_local $miles)
    )
  )

  (func $setInt (param $key i32) (param $value i32)
    (i32.store
      (get_local $key)
      (get_local $value)
    )
  )

  ;; Retrieve an integer stored at a given location in memory.
  (func $getInt (param $key i32) (result i32)
    (i32.load
      (get_local $key)
    )
  )

  ;; Perform division on two integers.  If the type parameter is 0, an integer
  ;; division is performed.  Otherwise a floating point division is performed.
  (func $div (param $num i32) (param $den i32) (param $type i32) (result i32)
    (if (result i32)
      (i32.eqz
        (get_local $type)
      )
      (then
        (i32.div_s
          (get_local $num)
          (get_local $den)
        )
      )
      (else
        (i32.trunc_s/f32
          (f32.div
            (f32.convert_s/i32
              (get_local $num)
            )
            (f32.convert_s/i32
              (get_local $den)
            )
          )
        )
      )
    )
  )


)