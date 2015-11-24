(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex
    },
    
    IS[ Times[s_IS, y__], vrs2_ ] := Block[
        {x, vrs1},
        
        IS[x, vrs1] = ScU[s];
        ScT[indexfunc] @ IS[ Times[x, y], Join[vrs1, vrs2] ]
    ];
]


End[];
