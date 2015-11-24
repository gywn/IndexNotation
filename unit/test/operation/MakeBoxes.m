(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["operation/MakeBoxes.m"]


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
    IT[ IS[ Subscript[A, {i_, j_, k_}], {k_} ], {i_,2}, {j_} ]
]


End[];
