(* ::Package:: *)

Begin["SymbolicTensor`temp`"];

With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex
    },
    
    ST /: ( s1 : ST[_, _] )\[TensorProduct]( s2 : ST[_, _] ) := Block[
        {x1, vrs1, x2, vrs2},
        
        ST[x1, vrs1] = ScU[s1];
        ST[x2, vrs2] = ScU[s2];
        
        ScT[indexfunc] @ ST[ x1 x2, Join[vrs2, vrs1] ]
    ];
]



End[];
