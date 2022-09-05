Check that default implementation data is installed in the dune package file.

  $ dune build @install
  $ dune_cmd cat _build/install/default/lib/a/dune-package | sed "s/(lang dune .*)/(lang dune <version>)/" | dune_cmd sanitize
  (lang dune <version>)
  (name a)
  (sections (lib .) (libexec .))
  (files
   (lib
    (A.cmi
     A.cmo
     A.cmt
     A.cmx
     A.ml
     A$ext_obj
     A__X.cmi
     A__X.cmti
     META
     default-impl/A.cmi
     default-impl/A.cmx
     default-impl/A__X.cmi
     default-impl/A__X.cmt
     default-impl/A__X.cmx
     default-impl/A__a_default.cmi
     default-impl/A__a_default.cmt
     default-impl/A__a_default.cmx
     default-impl/A__a_default.ml
     default-impl/a_default$ext_lib
     default-impl/a_default.cma
     default-impl/a_default.cmxa
     default-impl/x.ml
     dune-package
     opam
     x.mli))
   (libexec (default-impl/a_default.cmxs)))
  (library
   (name a)
   (kind normal)
   (virtual)
   (default_implementation a.default-impl)
   (main_module_name A)
   (modes byte native)
   (modules
    (wrapped
     (group
      (alias (name A) (obj_name A) (visibility public) (kind alias) (impl))
      (name A)
      (modules
       (module
        (name X)
        (obj_name A__X)
        (path X)
        (visibility public)
        (kind virtual)
        (intf))))
     (wrapped true))))
  (library
   (name a.default-impl)
   (kind normal)
   (archives
    (byte default-impl/a_default.cma)
    (native default-impl/a_default.cmxa))
   (plugins
    (byte default-impl/a_default.cma)
    (native default-impl/a_default.cmxs))
   (native_archives default-impl/a_default$ext_lib)
   (requires a)
   (implements a)
   (main_module_name A)
   (modes byte native)
   (modules
    (wrapped
     (group
      (alias
       (name A__a_default)
       (obj_name A__a_default)
       (visibility public)
       (kind alias)
       (impl))
      (name A)
      (modules
       (module
        (name X)
        (obj_name A__X)
        (path X)
        (visibility public)
        (kind impl_vmodule)
        (impl))))
     (wrapped true))))
