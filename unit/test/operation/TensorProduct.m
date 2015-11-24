(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["operation/TensorProduct.m"]


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
            IT[ a[i_, j_], TI[ {j_}, {i_} ] ] \[TensorProduct] IT[ b[i_, j_], TI[ {j_}, {i_} ] ],
            IT[ a[DI[1], DI[2]] b[DI[3], DI[4]], TI[ {DI[4]}, {DI[3]}, {DI[2]}, {DI[1]} ] ],
            TestID -> "number index" 
        ],

        VerificationTest[
            IT[ a[i_], TI[ {i_} ] ] \[TensorProduct] IT[ b[i_], TI[ {i_} ] ] \[TensorProduct] IT[ c[i_], TI[ {i_} ] ],
            IT[ a[DI[1]] b[DI[2]] c[DI[3]], TI[ {DI[3]}, {DI[2]}, {DI[1]} ] ],
            TestID -> "chain tensor product" 
        ]
    }
]


End[];
