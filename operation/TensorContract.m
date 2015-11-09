(* ::Package:: *)

Begin["SymbolicTensor`temp`"];

With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex,

        TC = TensorContract
    },
    
    ST /: c : TC[ ST[x_, vrs_], { ip_, ips___ } ] := Block[
        { l = Length[vrs], i1, i2, ri1, ri2, valid, v1, v2, n1, n2, x1, vrs1, v3 = Unique[] },
        
        {i1, i2} = Sort[ip];
        {ri1, ri2} = l + 1 - {i1, i2};
        valid = ri1 <= Length[vrs] && ri2 <= Length[vrs]
            && Length @ vrs[[ri1]] === 2 && Length @ vrs[[ri2]] === 2
            && vrs[[ri1, 2]] == vrs[[ri2, 2]];

        If[
            valid,

            {v1, n1} = vrs[[ri1]];
            {v2, n2} = vrs[[ri2]];
            vrs1 = Drop[ vrs, {ri2, ri1, ri1 - ri2} ]; (* ri1 > ri2 *)
            ST[x1, vrs1] = ScU @ ST[x, vrs1]; (* vrs1 could be TI[] *)

            TC[
                ScT[indexfunc] @ ST[
                    SS[ x1 /. AssociationThread[ {v1, v2}, {v3, v3} ], SI[ {v3, n1} ] ],
                    vrs1
                ],
                {ips} /. {
                    i_ ? IntegerQ /; i > i1 && i < i2 :> i - 1,
                    i_ ? IntegerQ /; i > i2 :> i - 2
                }
            ],
            
            Hold[c]
        ]
    ];
]



End[];
