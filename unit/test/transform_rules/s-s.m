(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-s.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        DI = IndexNotation`DummyIndex,
        
        ScT = IndexNotation`Scope`Transform
    },
    
    Global`RESULTS = {
        VerificationTest[
            IS[ IS[ a[i,j], SI[{i}] ], SI[{j}] ],
            IS[a[DI[1],DI[2]],SI[{DI[1]},{DI[2]}]],
            TestID -> "simple 1"
        ],
        
        VerificationTest[
            IS[ IS[ IS[ a[DI[1]], SI[{DI[1],a}] ], SI[{DI[1],b}] ], SI[{DI[1],c}] ],
            IS[ a[DI[1]], SI[ {DI[1],a}, {DI[3],c}, {DI[2],b} ] ],
            TestID -> "multiple layers"
        ],
        
        VerificationTest[
            IS[ IS[ a[i,j], SI[{i,3},{k,4}] ], SI[{j,1},{l,2}] ],
            IS[
                a[DI[1],DI[2]], 
                SI[
                    {DI[1],3}, {DI[2],1},
                    {DI[3],2}, {DI[4],4}
                ]
            ],
            TestID -> "sorting"
        ],
    
        VerificationTest[
            IS[ IS[ a[DI[1], DI[3]], SI[{DI[1],1}, {DI[3],2}] ], {i,3} ],
            IS[a[DI[1],DI[2]],SI[{DI[1],1},{DI[2],2},{DI[3],3}]],
            TestID -> "simple 2"
        ]
    }
]


End[];
