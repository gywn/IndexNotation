(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet[
    "DoubleContract.m",
    "operation/TensorContract.m",
    "operation/TensorProduct.m"
]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        DI = IndexNotation`DummyIndex,
        
        DC = IndexNotation`DoubleContract
    },
   
    Global`RESULTS = {
        VerificationTest[
            IT[ A[i_, j_, k_], TI[ {k_, 4}, {j_, 3}, {i_,2} ] ] ~DC~
                 IT[ B[i_, j_], TI[ {j_, 4}, {i_,3} ] ],
            IT[
                IS[ IS[ A[DI[3], DI[1], DI[2]] B[DI[1], DI[2]], SI[ {DI[1], 3} ] ], SI[ {DI[2], 4} ] ],
                TI[ {DI[3], 2} ]
            ]
        ],
        
        VerificationTest[
            IT[ A[i_, j_], TI[ {j_, 4}, {i_,3} ] ] ~DC~
                 IT[ B[i_, j_], TI[ {j_, 4}, {i_,3} ] ],
            IS[ IS[ A[DI[1], DI[2]] B[DI[1], DI[2]], SI[ {DI[1], 3} ] ], SI[ {DI[2], 4} ] ],
            TestID -> "to scalar"
        ]
    }
]


End[];
