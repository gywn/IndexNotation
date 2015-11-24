(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet[
    "operation/Tr.m",
    "operation/TensorContract.m"
]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        DI = IndexNotation`DummyIndex
    },
   
    Global`RESULTS = {
        VerificationTest[
            Tr @ IT[ A[i_, j_, k_], TI[ {k_, 3}, {j_, 3}, {i_,2} ] ],
            IT[ IS[ A[DI[2], DI[1], DI[1]], SI[ {DI[1], 3} ] ], TI[ {DI[2], 2} ] ]
        ],
        
        VerificationTest[
            Tr @ IT[ A[i_, j_], TI[ {j_, 3}, {i_,3} ] ],
            IS[ A[DI[1], DI[1]], SI[ {DI[1], 3} ] ],
            TestID -> "to scalar"
        ]
    }
]


End[];
