open Ctypes

module M (F : Ctypes.FOREIGN) = struct
  open F
  include Dpkg_types.M(Dpkg_types_stubs)

  let dpkg_version_blank =
    foreign "dpkg_version_blank"
      (ptr dpkg_version @-> returning void)

  let dpkg_version_is_informative =
    foreign "dpkg_version_is_informative"
      (ptr dpkg_version @-> returning bool)

  let dpkg_version_compare =
    foreign "dpkg_version_compare"
      (ptr dpkg_version @-> ptr dpkg_version @-> returning int)

  let dpkg_version_relate =
    foreign "dpkg_version_relate"
      (ptr dpkg_version @-> dpkg_relation @-> ptr dpkg_version @-> returning bool)

  let parseversion =
    foreign "parseversion"
      (ptr dpkg_version @-> string @-> ptr dpkg_error @-> returning int)
end
