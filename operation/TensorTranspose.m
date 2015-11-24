(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex,

        TT = TensorTranspose,
        Tr = Transpose
    },
    
    IT /: TT[ IT[x_, vrs_], {perm_List|perm_Cycles, phase_} ] := 
        ScT[indexfunc][ IT[ phase x, Reverse @ Permute[ Reverse[vrs], perm ] ] ];

    IT /: TT[s_IT, perm_List|perm_Cycles] := 
        TT[ s, {perm, 1} ];

    IT /: TT[s_IT] := 
        TT[ s, { {2, 1}, 1 } ];

    IT /: Tr[s_IT, perm_List|perm_Cycles] := 
        TT[ s, {perm, 1} ];

    IT /: Tr[s_IT] := 
        TT[ s, { {2, 1}, 1 } ];
]



End[];
