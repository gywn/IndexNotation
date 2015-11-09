(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet[
    "transform_rules/s-m-p.m",
    "transform_rules/s-p.m",
    "transform_rules/m-t.m",
    "transform_rules/p-t.m",
    "transform_rules/s-m-s.m",
    "transform_rules/s-t.m"
]


Begin["SymbolicTensor`test`"];


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,

        DI = SymbolicTensor`DumbIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            SS[ (a + 2( b[j_] + c[i_]) + a[i_]) a[i_] b[j_], SI[ {i_}, {j_} ] ],
            SS[a a[i_] b[j_], SI[{i_}, {j_}]] + SS[a[i_]^2 b[j_], SI[{i_}, {j_}]]
                + SS[2 a[i_] b[j_]^2, SI[{i_}, {j_}]] + SS[2 a[i_] b[j_] c[i_], SI[{i_}, {j_}]],
            TestID -> "1"
        ],
        
        VerificationTest[
            SS[ b[i_] SS[ b[j_] ST[ a[i_, j_], TI[ {i_, 2}, {j_, 3} ] ] + c[j_], SI[ {j_, 4} ] ], SI[ {i_, 5} ] ],
            ST[ SS[ a[DI[4], DI[3]] b[DI[1]] b[DI[2]], SI[ {DI[1], 4}, {DI[2], 5} ] ], TI[ {DI[4], 2}, {DI[3], 3} ] ]
                + SS[ c[DI[2]] b[DI[1]], SI[ {DI[1], 5}, {DI[2], 4} ] ],
            TestID -> "2"
        ]
    }  
]


End[];
