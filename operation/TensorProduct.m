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
    
    IT /: ( s1 : IT[_, _] )\[TensorProduct]( s2 : IT[_, _] ) := Block[
        {x1, vrs1, x2, vrs2},
        
        IT[x1, vrs1] = ScU[s1];
        IT[x2, vrs2] = ScU[s2];
        
        ScT[indexfunc] @ IT[ x1 x2, Join[vrs2, vrs1] ]
    ];
]



End[];
