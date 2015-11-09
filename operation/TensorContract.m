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
        { i1, i2, valid, v1, v2, n1, n2, x1, vrs1, v3 = Unique[] },
        
        {i1 ,i2} = Sort[ip];
        valid = i1 <= Length[vrs] && i2 <= Length[vrs]
            && Length @ vrs[[i1]] === 2 && Length @ vrs[[i2]] === 2
            && vrs[[i1, 2]] == vrs[[i2, 2]];

        If[
            valid,

            {v1, n1} = vrs[[i1]];
            {v2, n2} = vrs[[i2]];
            vrs1 = Drop[ vrs, {i1, i2, i2 - i1} ];
            ST[x1, vrs1] = ScU @ ST[x, vrs1];

            TC[
                ScT[indexfunc] @ ST[
                    SS[ x1 /. AssociationThread[ {v1, v2}, {v3, v3} ], SI[ {v3, n1} ] ],
                    vrs1
                ],
                {ips}
            ],
            
            Hold[c]
        ]
    ];
]



End[];
