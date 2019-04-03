open Ctypes

module M (T : Ctypes.TYPE) = struct
  open T
  let enum name vals =
    enum name (List.map (fun (a, b) -> (a, constant b int64_t)) vals)

  type dpkg_msg_type =
    DPKG_MSG_NONE | DPKG_MSG_WARN | DPKG_MSG_ERROR

  let dpkg_msg_type =
    enum "dpkg_msg_type" [
        DPKG_MSG_NONE  , "DPKG_MSG_NONE"  ;
        DPKG_MSG_WARN  , "DPKG_MSG_WARN"  ;
        DPKG_MSG_ERROR , "DPKG_MSG_ERROR" ;
      ]

  type dpkg_error
  let dpkg_error : dpkg_error structure typ = structure "dpkg_error"
  let type_ = field dpkg_error "type" dpkg_msg_type
  let () = seal dpkg_error
                
  type dpkg_version
  let dpkg_version : dpkg_version structure typ = structure "dpkg_version"
  let epoch    = field dpkg_version "epoch"    int
  let version  = field dpkg_version "version"  (ptr char)
  let revision = field dpkg_version "revision" (ptr char)
  let () = seal dpkg_version

  type dpkg_relation =
    DPKG_RELATION_NONE | DPKG_RELATION_EQ | DPKG_RELATION_LT
    | DPKG_RELATION_LE | DPKG_RELATION_GT | DPKG_RELATION_GE

  let dpkg_relation =
    enum "dpkg_relation" [
        DPKG_RELATION_NONE , "DPKG_RELATION_NONE" ;
        DPKG_RELATION_EQ   , "DPKG_RELATION_EQ"   ;
        DPKG_RELATION_LT   , "DPKG_RELATION_LT"   ;
        DPKG_RELATION_LE   , "DPKG_RELATION_LE"   ;
        DPKG_RELATION_GT   , "DPKG_RELATION_GT"   ;
        DPKG_RELATION_GE   , "DPKG_RELATION_GE"   ;
      ]
end
