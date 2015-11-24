(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        indexfunc = IndexNotation`DummyIndex
    },
    
    IS[ Plus[x_, y__], vrs_ ]
        (*/; SrI[ x, Verbatim /@ vrs[[All, 1]] ] =!= {}*)
        := IS[x, vrs] + IS[Plus[y], vrs];
]


End[];
