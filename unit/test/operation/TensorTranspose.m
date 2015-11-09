(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["operation/TensorTranspose.m"]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        DI = SymbolicTensor`DumbIndex,
        
        TT = TensorTranspose,
        Tr = Transpose
    },
    
    {
        VerificationTest[
            TT @ ST[ a[i_, j_] b[k_, l_], TI[ {l_}, {k_}, {j_}, {i_} ] ],
            ST[ a[DI[2], DI[1]] b[DI[3], DI[4]], TI[ {DI[4]}, {DI[3]}, {DI[2]}, {DI[1]} ] ],
            TestID -> "default transpose: outer most two levels" 
        ],
        
        VerificationTest[
            TT[ ST[ a[i_, j_] b[k_, l_], TI[ {l_}, {k_}, {j_}, {i_} ] ], {{2,3,1}, I} ],
            ST[ I a[DI[2], DI[3]] b[DI[1], DI[4]], TI[ {DI[4]}, {DI[3]}, {DI[2]}, {DI[1]} ] ],
            TestID -> "transpose with generator" 
        ]
    }
]
