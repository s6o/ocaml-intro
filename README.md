# OCaml (setup) intro with VSCode (MacOS)

This is short intro on how to set up VSCode for small OCaml project so as
to experiment with a actual build and executable setup instead of just _utop_
when reading through: [Real World OCaml](https://dev.realworldocaml.org/guided-tour.html)

The first part is largerly a summary from the installation
[instructions](https://dev.realworldocaml.org/install.html) from Real World OCaml.

In addition the setup below shows the not so obvious steps for an OCaml novice,
when setting up [build system](https://github.com/ocaml/dune) and [formatting](https://github.com/ocaml-ppx/ocamlformat) with VSCode.

## Pre-requisites

```bash
brew install libx11 fswatch
```

NOTE: There might be other (native) dependencies I already had but did not notice.

## Package manager

```bash
brew install opam
opam init
```

For making sure your shell is in the right state:

```bash
eval $(opam env)
```

## Compiler

At present the latest release is 4.11.1 but you can check [releases.](https://ocaml.org/releases)

```bash
opam switch create 4.11.1
```

## REPL (utop), dune (build system), ocamlformat, ocaml-lsp-server

```bash
opam install core async yojson core_extended core_bench cohttp-async async_graphics cryptokit menhir utop fswatch ocamlformat ocaml-lsp-server
```

### REPL (utop) configuration

Is stored in ~/.ocamlinit with following contents:

```text
#use "topfind";;
#thread;;
#require "core.top";;
#require "core.styntax";;
```

### First thing when running the REPL

```base
utop
open Core;;
```

As many examples use labeled arguments e.g. for List.map which is not the OCaml
standard List.map not supporting labled arguments, but Core's List.map which
supports f:('a -> 'b)

## Project setup

These list how the *ocaml_intro* project was set up and can be used for your
next project.

```bash
mkdir ~/ocaml_intro
cd ocaml_intro
dune init executable ocaml_intro
```

### Building

```bash
dune build
```

or

```bash
dune build --watch
```

### Running the executable

```bash
_build/default/ocaml_intro.exe
```

### Formatting

In your project directory, minimal [ocamlformat](https://github.com/ocaml-ppx/ocamlformat) configuration.

```bash
echo "profile = sparse" > .ocamlformat
```

## VSCode

The recommended [plugin](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
