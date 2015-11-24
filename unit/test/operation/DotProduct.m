(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet[
    "operation/DotProduct.m",
    "operation/TensorProduct.m",
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
    
    Global`RESULTS = 
    VerificationTest[
        IT[ A[i_, j_, k_], TI[ {k_, 4}, {j_, 3}, {i_,2} ] ] . IT[ B[i_, j_], TI[ {j_, 5}, {i_, 4} ] ],
        IT[ IS[ A[DI[2], DI[3], DI[1]] B[DI[1], DI[4]], SI[ {DI[1], 4} ] ],
            TI[ {DI[4], 5}, {DI[3], 3}, {DI[2], 2} ] ]
    ]
]


End[];
