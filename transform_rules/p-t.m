(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex
    },
    
    ST /: s : Plus[ s1 : ST[x1_, vrs1_], s2 : ST[x2_, vrs2_], y___ ] := Block[
        {x3, vrs3, x4, vrs4, uniques, rpl1, rpl2},

        If[
            vrs1[[All, 2;;-1]] === vrs2[[All, 2;;-1]], (* same index structure *)

            ST[x3, vrs3] = ScU[s1];
            ST[x4, vrs4] = ScU[s2];
            uniques = Cases[ vrs3, {i_, ___} :> Unique[] ];
            rpl1 = AssociationThread[ List @@ vrs3[[All, 1]], uniques ];
            rpl2 = AssociationThread[ List @@ vrs4[[All, 1]], uniques ];
            ST[x3, vrs3] = ST[x3, vrs3] /. rpl1;
            ST[x4, vrs4] = ST[x4, vrs4] /. rpl2;
            ScT[indexfunc] @ ST[x3 + x4, vrs3] + Plus[y],

            Hold[s]
        ]
    ];
]


End[];
