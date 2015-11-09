(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet[
    "operation/Tr.m",
    "operation/TensorContract.m"
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
            Tr @ ST[ A[i_, j_, k_], TI[ {k_, 3}, {j_, 3}, {i_,2} ] ],
            ST[ SS[ A[DI[2], DI[1], DI[1]], SI[ {DI[1], 3} ] ], TI[ {DI[2], 2} ] ]
        ],
        
        VerificationTest[
            Tr @ ST[ A[i_, j_], TI[ {j_, 3}, {i_,3} ] ],
            SS[ A[DI[1], DI[1]], SI[ {DI[1], 3} ] ],
            TestID -> "to scalar"
        ]
    }
]


End[];
