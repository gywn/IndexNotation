(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["operation/TensorProduct.m"]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        DI = SymbolicTensor`DumbIndex
    },
    
    {
        VerificationTest[
            ST[ a[i_, j_], TI[ {j_}, {i_} ] ] \[TensorProduct] ST[ b[i_, j_], TI[ {j_}, {i_} ] ],
            ST[ a[DI[1], DI[2]] b[DI[3], DI[4]], TI[ {DI[4]}, {DI[3]}, {DI[2]}, {DI[1]} ] ],
            TestID -> "number index" 
        ],

        VerificationTest[
            ST[ a[i_], TI[ {i_} ] ] \[TensorProduct] ST[ b[i_], TI[ {i_} ] ] \[TensorProduct] ST[ c[i_], TI[ {i_} ] ],
            ST[ a[DI[1]] b[DI[2]] c[DI[3]], TI[ {DI[3]}, {DI[2]}, {DI[1]} ] ],
            TestID -> "chain tensor product" 
        ]
    }
]
