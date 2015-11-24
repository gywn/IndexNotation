(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        indexfunc = IndexNotation`DummyIndex
    },
    
    (**
     *  Simple sum like (2+\[Pi]) won't be attributed
     *)
    
    IS[ Times[ Plus[x_, y__], z__ ], vrs_ ]
        (*/; SrI[ x, Verbatim /@ vrs[[All, 1]] ] =!= {}*)
        := IS[ Times[x, z] + Times[ Plus[y], z ], vrs ];
]


End[];
