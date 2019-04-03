let prefix = "dpkg_stub"

let prologue = "
  #define LIBDPKG_VOLATILE_API

  #include <dpkg/error.h>
  #include <dpkg/version.h>
  #include <dpkg/dpkg-db.h>
"
               
type target = None | C | ML
let target = ref (None : target)
let set_target value =
  fun () -> target := value

let () =
  Arg.(parse
         [ "--ml", Unit (set_target ML), "";
           "--c" , Unit (set_target C),  "" ])
    (fun _ -> failwith "Unexpected argument")
    "stubsgen [--ml | --c]"

let () =
  match !target with
  | None -> failwith "Target expected"
  | C ->
     print_endline prologue;
     Cstubs.write_c  Format.std_formatter ~prefix (module Dpkg_functions.M)
  | ML ->
     print_endline "(* Hello from ML. *)";
     Cstubs.write_ml Format.std_formatter ~prefix (module Dpkg_functions.M)
