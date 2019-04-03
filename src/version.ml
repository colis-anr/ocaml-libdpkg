open Ctypes
open Dpkg_bindings

type t = dpkg_version structure ptr

let make_ptr type_ =
  allocate type_ (make type_)

let blank () =
  let dpkg_version_ptr = make_ptr dpkg_version in
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
  let version = make_ptr dpkg_version in
  let error = make_ptr dpkg_error in
  let ret = parseversion version str error in
  match ret, getf (!@ error) Dpkg_bindings.type_ with
  | 0, _ ->
    (version, None)
  | _, DPKG_MSG_WARN ->
    (version, Some (getf (!@ error) Dpkg_bindings.str))
  | _, DPKG_MSG_ERROR ->
    raise (Error.Error (getf (!@ error) Dpkg_bindings.str))
  | _ ->
    assert false
