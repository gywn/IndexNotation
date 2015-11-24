# IndexNotation: Index Notation for Mathematica

IndexNotation provides long missing dummy-indices structures in Mathematica to
enable symbolic tensor calculation, such as automatic re-indexing and
simplification, Kronecker delta reduction, tensor contraction, tensor transpose
and series expansion, etc.

Its usage scenarios would be:

  - Symbolic matrix calculation for engineering and Physics
  - Help generating and verify numerical codes written in C or FORTRAN

## Installation

    $ cd ~/Library/Mathematica/Applications
    $ git clone https://github.com/hijack111/IndexNotation.git

## Usage

A very short example:

    << IndexNotation`
    
    A = IndexTensor[a[i, j], {i, n}, {j, m}];
    B = IndexTensor[b[i, j], {i, n}, {j, m}];
    Print[A.B];  (* Box structures wrapped by InterpretationBox *)
    Print[A.B // InputForm];  (* Fine grain editing *)
