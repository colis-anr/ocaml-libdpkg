type t

val blank : unit -> t

val is_informative : t -> bool

val compare : t -> t -> int

type relation = Eq | Lt | Le | Gt | Ge

val relate : t -> relation -> t -> bool

val parse : string -> t * string option
(** Parses a string as a Dpkg version number. The [string option] can contain a
    warning. Raises [Error.Error]. *)
