(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex
    },
    
    IS[s_IT, vrs2_] := Block[
        {x, vrs1},
        
        IT[x, vrs1] = ScU[s];
        ScT[indexfunc] @ IT[ IS[x, vrs2], vrs1 ]
    ];
]


End[];
