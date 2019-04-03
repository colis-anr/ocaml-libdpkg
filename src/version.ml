open Ctypes
open Dpkg_bindings

type t = dpkg_version structure ptr

let make_dpkg_version_ptr () =
  allocate dpkg_version (make dpkg_version)

let blank () =
  let dpkg_version_ptr = make_dpkg_version_ptr () in
  dpkg_version_blank dpkg_version_ptr;
  dpkg_version_ptr

let is_informative = dpkg_version_is_informative
    
let compare = dpkg_version_compare

type relation = Eq | Lt | Le | Gt | Ge

let relate v1 rel v2 =
  let dpkg_rel =
    match rel with
    | Eq -> DPKG_RELATION_EQ
    | Lt -> DPKG_RELATION_LT
    | Le -> DPKG_RELATION_LE
    | Gt -> DPKG_RELATION_GT
    | Ge -> DPKG_RELATION_GE
  in
  dpkg_version_relate v1 dpkg_rel v2
                
let parse str =
  let dpkg_version_ptr = make_dpkg_version_ptr () in
  let ret = parseversion dpkg_version_ptr str (allocate dpkg_error (make dpkg_error)) in
  if ret = 0 then
    Some dpkg_version_ptr
  else
    None
