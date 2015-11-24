(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex
    },
    
    
    IT[s_IT, vrs2_] :=  Block[
        {x, vrs1},
        
        IT[x, vrs1] = ScU[s];
        ScT[indexfunc] @ IT[ x, Join[vrs1, vrs2] ]
    ];
]



End[];
