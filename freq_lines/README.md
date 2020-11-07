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

## Second version - Counter module

Despite what the [book](https://dev.realworldocaml.org/files-modules-and-programs.html) claims when writing this - dune could not build the counter.ml if the counter.mli was missing.

```bash
File "freq.ml", line 5, characters 53-66:
5 |   In_channel.fold_lines In_channel.stdin ~init:[] ~f:Counter.touch
                                                         ^^^^^^^^^^^^^
Error: Unbound value Counter.touch
File "counter.ml", line 3, characters 4-9:
3 | let touch counts line =
        ^^^^^
Error (warning 32): unused value touch.
```
