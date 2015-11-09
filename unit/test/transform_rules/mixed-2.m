(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet[
    "transform_rules/s-m-p.m",
    "transform_rules/s-p.m",
    "transform_rules/m-t.m",
    "transform_rules/p-t.m",
    "transform_rules/s-m-s.m",
    "transform_rules/s-t.m",
    "transform_rules/s-s.m",
    "transform_rules/t-t.m",
    "transform_rules/s-m.m"
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
            SS[ b[i_] SS[ b[j_] ST[ a[i_, j_], TI[ {i_, 2}, {j_, 3} ] ] + c[j_], SI[ {j_, 4} ] ], SI[ {i_, 4} ] ],
            ST[ a[DI[3], DI[2]] SS[ b[DI[1]], SI[ {DI[1], 4} ] ]^2, TI[ {DI[3], 2}, {DI[2], 3} ] ]
                + SS[ c[DI[1]], SI[ {DI[1], 4} ] ] SS[ b[DI[1]], SI[ {DI[1], 4} ] ],
            TestID -> "1"
        ]
    }
]


End[];
