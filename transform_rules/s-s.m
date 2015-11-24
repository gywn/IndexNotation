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
    
    IS[s_IS, vrs2_] :=  Block[
        {x, vrs1},
        
        IS[x, vrs1] = ScU[s];
        ScT[indexfunc] @ IS[ x, Join[vrs1, vrs2] ]
    ];
]


End[];
