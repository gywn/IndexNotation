(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        KD = KroneckerDelta,
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScD = IndexNotation`Scope`UniqueDummyIndex,
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex,
        
        TD = IndexNotation`TensorDerivative
    },
    
    TD[ Subscript[s_, h_[_, _]], {_, n1___}, {_, n2___} ] @ x_
    := Module[
        {
            tmp1 = ScD @ $ModuleNumber ++,
            tmp2 = ScD @ $ModuleNumber ++
        },
        
        ScT[indexfunc] @ If[
            (* In order to keep up symmetry of {tmp1, tmp2} with {k1, k2} *)
            MemberQ[ Attributes[h], Orderless ],
            
            x /. Subscript[ Verbatim[s], Verbatim[h][k1_, k2_] ] :>
                IT[
                    ( KD[k1, tmp1] KD[k2, tmp2] + KD[k2, tmp1] KD[k1, tmp2] ) / 2,
                    {tmp1, n1}, {tmp2, n2}
                ],
            
            x /. Subscript[ Verbatim[s], Verbatim[h][k1_, k2_] ] :>
                IT[
                    KD[k1, tmp1] KD[k2, tmp2],
                    {tmp1, n1}, {tmp2, n2}
                ]
        ]

    ];
]



End[];
