let prologue = "
  #define LIBDPKG_VOLATILE_API

  #include <dpkg/error.h>
  #include <dpkg/version.h>
  #include <dpkg/dpkg-db.h>
"
                
let () =
  print_endline prologue;
  Cstubs.Types.write_c Format.std_formatter (module Dpkg_types.M)
