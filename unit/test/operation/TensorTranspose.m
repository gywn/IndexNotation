(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["operation/TensorTranspose.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        DI = IndexNotation`DummyIndex,
        
        TT = TensorTranspose,
        Tr = Transpose
    },
    
    Global`RESULTS = {
        VerificationTest[
            TT @ IT[ a[i_, j_] b[k_, l_], TI[ {l_}, {k_}, {j_}, {i_} ] ],
            IT[ a[DI[2], DI[1]] b[DI[3], DI[4]], TI[ {DI[4]}, {DI[3]}, {DI[2]}, {DI[1]} ] ],
            TestID -> "default transpose: outer most two levels" 
        ],
        
        VerificationTest[
            TT[ IT[ a[i_, j_] b[k_, l_], TI[ {l_}, {k_}, {j_}, {i_} ] ], {{2,3,1}, I} ],
            IT[ I a[DI[2], DI[3]] b[DI[1], DI[4]], TI[ {DI[4]}, {DI[3]}, {DI[2]}, {DI[1]} ] ],
            TestID -> "transpose with generator" 
        ]
    }
]


End[];
