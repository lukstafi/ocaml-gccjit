(lang dune 3.11)

(using ctypes 0.3)

(name gccjit)

(version 0.3.2)

(generate_opam_files true)

(source
 (github lukstafi/ocaml-gccjit))

(authors "Nicolas Ojeda Bar <n.oje.bar@gmail.com>")

(maintainers "Lukasz Stafiniak")

(license "MIT")

(documentation
 https://github.com/lukstafi/ocaml-gccjit/blob/master/README.md)

(package
 (name gccjit)
 (synopsis "Bindings to libgccjit, the GCC JIT compiler")
 (description
  "`libgccjit` is an embeddable shared library being included in GCC for adding compilation to existing programs using GCC as the backend. This package organizes the API of `gccjit` into a few types and their corresponding modules.")
 (depends
  (ocaml
   (>= 4.08.0))
  dune
  base-unix
  (ctypes
   (>= 0.14.0))
  ctypes-foreign
  conf-libgccjit
  (ppx_expect
   (and
    :with-test
    (>= v0.9.0))))
 (tags
  (gcc jit gccjit)))
