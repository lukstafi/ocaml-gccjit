open Gccjit

let%expect_test "square" =
  let ctx = Context.create () in

  (* Turn these on to get various kinds of debugging *)
  (* Context.set_option ctx Context.Dump_initial_tree true; *)
  Context.set_option ctx Context.Dump_initial_gimple true;

  (* Context.set_option ctx Context.Dump_generated_code true; *)

  (* Adjust this to control optimization level of the generated code *)
  Context.set_option ctx Context.Optimization_level 3;

  (* Create parameter "i" *)
  let param_i = Param.create ctx Type.(get ctx Int) "i" in

  (* Create the function *)
  let fn = Function.create ctx Function.Exported Type.(get ctx Int) "square" [ param_i ] in

  (* Create a basic block within the function *)
  let block = Block.create fn in

  (* This basic block is relatively simple *)
  let expr = RValue.binary_op ctx Mult Type.(get ctx Int) (RValue.param param_i) (RValue.param param_i) in

  Block.return block expr;

  (* Having populated the context, compile it *)
  let res = Context.compile ctx in

  (* Look up a specific machine code routine within the gccjit.Result, in this
     case, the function we created above: *)
  let callable = Result.code res "square" Ctypes.(int @-> returning int) in

  let output = Str.global_replace (Str.regexp {|[0-9]+|}) "NNN" [%expect.output] in
  print_endline output;
  [%expect
    {|
      int square (int i)
      {
        int D.NNN;

        <D.NNN>:
        D.NNN = i * i;
        return D.NNN;
      } |}];

  (* Now try running the code *)
  let () = print_endline @@ Int.to_string @@ callable 5 in
  [%expect {| 25 |}]
