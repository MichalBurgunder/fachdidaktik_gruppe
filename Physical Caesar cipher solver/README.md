# Physical Caesar cipher solver

## Usage

You can print out the given `Physical-Caesar-cipher-solver.pdf`, it contains 6
pairs of rings per page.
The students should cut out a pair of a small and a large ring each.
The rings can be placed on top of each other.
To easily rotate them, they can puncture the middle part.
By rotating them by 13 increments, they get a ROT13 encryption/decryption
instrument.
If rotated by 3, they get the same for the Caesar cipher.

## Compilation

This document was created with the help of [Typst](https://typst.app/), a modern
alternative to [LaTeX](https://www.latex-project.org/).

To compile it, install Typst via e.g., a package manager and then execute the
following command:

```sh
typst compile Physical-Caesar-cipher-solver.typ
```

This will create `Physical-Caesar-cipher-solver.pdf`, which fills an entire page
with the samples.

If you prefer print fewer or more copies (e.g., 1), you can specify that with
the help of the `--input` flag:

```sh
typst compile Physical-Caesar-cipher-solver.typ --input copies=1
```

You can change multiple parameters by specifying `--input key=value` multiple
times, like so:

```sh
typst compile Physical-Caesar-cipher-solver.typ --input radius_inner=7 --input columns=2
```

The parameters you can change are as follows:

- `number_copies`: How many copies to create in total
- `columns`: How many columns should we distribute the rings over?
- `offset`: The space reserved for the letter
- `radius_inner`: The radius until the inner line of the smaller ring
- `radius_outer`: The radius until the outer line of the bigger ring
- `use_numbers`: If `true`, uses numbers instead of the Latin alphabet
