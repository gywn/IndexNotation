(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/t-t.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        DI = SymbolicTensor`DumbIndex,
        
        ScT = SymbolicTensor`Scope`Transform
    },
    
    Global`RESULTS = {
        VerificationTest[
            ST[ ST[ a[i,j], TI[{j}] ], TI[{i}] ],
            ST[a[DI[1],DI[2]],TI[{DI[2]},{DI[1]}]],
            TestID -> "simple 1" 
        ],
        
        VerificationTest[
            ST[ ST[ ST[ a[DI[1]], TI[{DI[1],a}] ], TI[{DI[1],b}] ], TI[{DI[1],c}] ],
            ST[ a[DI[3]], TI[ {DI[3],a}, {DI[2],b}, {DI[1],c} ] ],
            TestID -> "multiple layers"
        ],
        
        VerificationTest[
            ST[ ST[ a[i,j], TI[{i,1},{k,3}] ], TI[{j,2},{l,4}] ],
            ST[
                a[DI[4],DI[2]], 
                TI[
                    {DI[4],1}, {DI[3],3},
                    {DI[2],2}, {DI[1],4}
                ]
            ],
            TestID -> "sorting" 
        ],
        
        VerificationTest[
            ST[ ST[ a[DI[1], DI[3]], TI[{DI[1],1}, {DI[3],2}] ], {i,3} ],
            ST[a[DI[3],DI[2]],TI[{DI[3],1},{DI[2],2},{DI[1],3}]],
            TestID -> "simple 2"
        ]
    }
]


End[];
