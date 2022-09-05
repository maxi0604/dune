Basic test showcasing the feature. Every directory creates a new level of aliasing.
  $ dune build
  hello from nested module bar
  hello from nested module B

  $ find _build -iname "*.ml-gen" | while read file; do echo "contents of $file"; cat $file; echo "--------"; done;
  contents of _build/default/lib/Foolib.ml-gen
  (* generated by dune *)
  
  (** @canonical Foolib.Foo *)
  module Foo = Foolib__Foo
  --------
  contents of _build/default/lib/Foolib__Foo.ml-gen
  (* generated by dune *)
  
  (** @canonical Foolib.A *)
  module A = Foolib__Foo__A
  
  (** @canonical Foolib.Bar *)
  module Bar = Foolib__Foo__Bar
  --------
  contents of _build/default/lib/Foolib__Foo__A.ml-gen
  (* generated by dune *)
  
  (** @canonical Foolib.B *)
  module B = Foolib__Foo__A__B
  --------
