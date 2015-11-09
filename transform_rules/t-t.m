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
    
    
    ST[ s_ST, vrs2_ ] :=  Block[
        {x, vrs1},
        
        ST[x, vrs1] = ScU[s];
        ScT[indexfunc] @ ST[ x, Join[vrs1, vrs2] ]
    ];
]



End[];
