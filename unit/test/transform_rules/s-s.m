(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-s.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        DI = SymbolicTensor`DumbIndex,
        
        ScT = SymbolicTensor`Scope`Transform
    },
    
    Global`RESULTS = {
        VerificationTest[
            SS[ SS[ a[i,j], SI[{i}] ], SI[{j}] ],
            SS[a[DI[1],DI[2]],SI[{DI[1]},{DI[2]}]],
            TestID -> "simple 1"
        ],
        
        VerificationTest[
            SS[ SS[ SS[ a[DI[1]], SI[{DI[1],a}] ], SI[{DI[1],b}] ], SI[{DI[1],c}] ],
            SS[ a[DI[1]], SI[ {DI[1],a}, {DI[3],c}, {DI[2],b} ] ],
            TestID -> "multiple layers"
        ],
        
        VerificationTest[
            SS[ SS[ a[i,j], SI[{i,3},{k,4}] ], SI[{j,1},{l,2}] ],
            SS[
                a[DI[1],DI[2]], 
                SI[
                    {DI[1],3}, {DI[2],1},
                    {DI[3],2}, {DI[4],4}
                ]
            ],
            TestID -> "sorting"
        ],
    
        VerificationTest[
            SS[ SS[ a[DI[1], DI[3]], SI[{DI[1],1}, {DI[3],2}] ], {i,3} ],
            SS[a[DI[1],DI[2]],SI[{DI[1],1},{DI[2],2},{DI[3],3}]],
            TestID -> "simple 2"
        ]
    }
]


End[];
