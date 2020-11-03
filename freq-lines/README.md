# Line frequency

Demonstration of building and linking without dune.

```bash
ocamlfind ocamlopt -linkpkg -package base -package stdio freq.ml -o freq
```

or as usual with dune

```bash
dune build
```

## Testing the program

```bash
grep -Eo '[[:alpha:]]+' freq.ml | _build/default/freq.exe
```

or

```bash
grep -Eo '[[:alpha:]]+' freq.ml | dune exec ./freq.exe
```
