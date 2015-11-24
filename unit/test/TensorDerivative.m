(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet[
    "TensorDerivative.m",
    "transform_rules/t-t.m",
    "transform_rules/s-t.m",
    "transform_rules/s-d.m"
]


Begin["IndexNotation`test`"];


With[
    {
        KD = KroneckerDelta,
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        DI = IndexNotation`DummyIndex,
        
        TD = IndexNotation`TensorDerivative
    },
   
    Global`RESULTS = {
        VerificationTest[
            TD[ Subscript[F, {i,j}], {i,3}, {j,3} ] @ IT[ Subscript[F, {i,j}], {i,3}, {j,3} ],
            IT[ KD[i,k] KD[j,l], {i,3}, {j,3}, {k,3}, {l,3} ]
        ],
        
        VerificationTest[
            TD[ Subscript[F, {i,j}], {i,3}, {j,3} ] @ IS[ Subscript[F, {i,i}], {i,3} ],
            IT[ KD[i,j], {i,3}, {j,3} ],
            TestID -> "from scalar"
        ]
    }
]


End[];
