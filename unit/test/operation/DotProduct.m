(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet[
    "operation/DotProduct.m",
    "operation/TensorProduct.m",
    "operation/TensorContract.m"
]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        DI = SymbolicTensor`DumbIndex
    },
    
    VerificationTest[
        ST[ A[i_, j_, k_], TI[ {k_, 4}, {j_, 3}, {i_,2} ] ] . ST[ B[i_, j_], TI[ {j_, 5}, {i_, 4} ] ],
        ST[ SS[ A[DI[2], DI[3], DI[1]] B[DI[1], DI[4]], SI[ {DI[1], 4} ] ],
            TI[ {DI[4], 5}, {DI[3], 3}, {DI[2], 2} ] ]
    ]
]
