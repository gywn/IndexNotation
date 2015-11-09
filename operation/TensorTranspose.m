(* ::Package:: *)

Begin["SymbolicTensor`temp`"];

With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex,

        TT = TensorTranspose,
        Tr = Transpose
    },
    
    ST /: TT[ ST[x_, vrs_], {perm_List|perm_Cycles, phase_} ] := 
        ScT[indexfunc][ ST[ phase x, Reverse @ Permute[ Reverse[vrs], perm ] ] ];

    ST /: TT[s_ST, perm_List|perm_Cycles] := 
        TT[ s, {perm, 1} ];

    ST /: TT[s_ST] := 
        TT[ s, { {2, 1}, 1 } ];

    ST /: Tr[s_ST, perm_List|perm_Cycles] := 
        TT[ s, {perm, 1} ];

    ST /: Tr[s_ST] := 
        TT[ s, { {2, 1}, 1 } ];
]



End[];
