(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScD = IndexNotation`Scope`UniqueDummyIndex,
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex
    },
    
    IT /: s : Plus[ s1 : IT[x1_, vrs1_], s2 : IT[x2_, vrs2_], y___ ] := Block[
        {x3, vrs3, x4, vrs4, uniques, rpl1, rpl2},

        If[
            vrs1[[All, 2;;-1]] === vrs2[[All, 2;;-1]], (* same index structure *)

            IT[x3, vrs3] = ScU[s1];
            IT[x4, vrs4] = ScU[s2];
            uniques = Cases[ vrs3, {i_, ___} :> ScD @ $ModuleNumber ++ ];
            rpl1 = AssociationThread[ List @@ vrs3[[All, 1]], uniques ];
            rpl2 = AssociationThread[ List @@ vrs4[[All, 1]], uniques ];
            IT[x3, vrs3] = IT[x3, vrs3] /. rpl1;
            IT[x4, vrs4] = IT[x4, vrs4] /. rpl2;
            ScT[indexfunc] @ IT[x3 + x4, vrs3] + Plus[y],

            Hold[s]
        ]
    ];
]


End[];
