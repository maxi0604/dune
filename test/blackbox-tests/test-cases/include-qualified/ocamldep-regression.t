We should forbid lib interfaces modules from depending on themselves:

  $ cat > dune-project << EOF
  > (lang dune 3.7)
  > EOF

  $ cat > dune << EOF
  > (include_subdirs qualified)
  > (library
  >  (name foo))
  > EOF

  $ cat > foo.ml <<EOF
  > let () = Foo.f ()
  > EOF

  $ touch bar.ml

  $ dune build @check
  deps for "Foo" = []
  deps for "Foo__Bar" = []
  File "foo.ml", line 1, characters 9-14:
  1 | let () = Foo.f ()
               ^^^^^
  Error: Unbound module Foo
  [1]

We also forbid submodules from depending on their interface modules:

  $ rm foo.ml bar.ml
  $ mkdir baz
  $ touch baz/baz.ml
  $ cat >baz/bar.ml <<EOF
  > let () = Baz.f
  > EOF

  $ dune build
  deps for "Foo__Baz" = []
  deps for "Foo__Baz__Bar" = [ "Foo__Baz" ]
  File "baz/bar.ml", line 1, characters 9-14:
  1 | let () = Baz.f
               ^^^^^
  Error: Unbound value Baz.f
  [1]

Or their parent interface modules:

  $ rm -rf baz
  $ touch baz.ml
  $ mkdir -p baz/foo/
  $ cat >baz/foo/z.ml <<EOF
  > let () = Baz.f
  > EoF
  $ dune build
