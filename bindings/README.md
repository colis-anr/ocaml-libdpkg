ocaml-libdpkg - bindings
========================

This directory contains the low-level bindings to `libdpkg`. These bindings are
defined using the Ctypes OCaml library.

The two files actually defining the bindings are `types/dpkg_types.ml` and
`functions/dpkg_functions.ml`. The other files are here to define the machinery
required by Ctypes. In the end, we get a `libdpkg.bindings` library containing
OCaml wrappers around all the C endpoints defined.

The higher-level bindings are defined using these low-level bindings. They can
be found in the `../src` directory.
