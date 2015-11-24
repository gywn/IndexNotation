(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Scope/Transform.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        ScT = IndexNotation`Scope`Transform
    },
    
Block[
    {indexfunc},
    
    indexfunc[i_] := Idx[i];
    Global`RESULTS = {
        VerificationTest[
            ScT[indexfunc] @ IT[ IS[ a_ + b_, SI[{a_,4}] ], TI[{b_,3}] ],
            IT[ IS[ Idx[1] + Idx[2], SI[{Idx[1],4}] ], TI[{Idx[2],3}] ],
            TestID -> "multiple layers"
        ],
        
        VerificationTest[
            ScT[indexfunc][ IS[ a_ + b_, SI[{a_,4}, {b_,3}]] ],
            ScT[indexfunc][ IS[ b_ + a_, SI[{b_,4}, {a_,3}]] ],
            TestID -> "determinated by SumIndex order"
        ],
        
        VerificationTest[
            ScT[indexfunc][ IS[ A[a_] + B[b_], SI[{a_}, {b_}]] ],
            ScT[indexfunc][ IS[ A[b_] + B[a_], SI[{b_}, {a_}]] ],
            TestID -> "determinated by Sum content"
        ],
        
        VerificationTest[
            ScT[indexfunc][ IS[ A[a_, c_], SI[{c_}] ] + IS[ A[a_, d_], SI[{d_}] ] ],
            ScT[indexfunc][ 2 IS[ A[a_, c_], SI[{c_}] ] ],
            TestID -> "complex identification 1"
        ],
        
        VerificationTest[
            ScT[indexfunc][ IS[ IS[ A[a_, c_], SI[{c_}] ] + IS[ A[b_, d_], SI[{d_}] ], SI[{a_}, {b_}]] ],
            ScT[indexfunc][ IS[ IS[ A[b_, e_], SI[{e_}] ] + IS[ A[a_, f_], SI[{f_}] ], SI[{b_}, {a_}]] ],
            TestID -> "complex identification 2"
        ],
        
        VerificationTest[
            ScT[indexfunc][ IS[ Idx[1] A[c_], SI[{c_}] ] ],
            ScT[indexfunc][ IS[ Idx[1] A[ Idx[2] ], SI[{ Idx[2] }] ] ],
            TestID -> "Simple shadowing"
        ],
        
        VerificationTest[
            ScT[indexfunc][ IS[ c_ + Idx[1], SI[{c_, 3}, {Idx[1], 4}] ] ],
            ScT[indexfunc][ IS[ Idx[1] + Idx[2], SI[{Idx[1], 3}, {Idx[2], 4}] ] ],
            TestID -> "Renaming occupied index"
        ],
        
        VerificationTest[
            ScT[indexfunc][ IS[ A[a_, a_, b_], SI[{a_}, {b_}]] ],
            ScT[indexfunc][ IS[ A[d_, d_, c_], SI[{c_}, {d_}]] ],
            TestID -> "Structual equivalence: Sum"
        ],
        
        VerificationTest[
            ScT[indexfunc][ IT[ A[a_, a_, b_], TI[{a_}, {b_}]] ],
            ScT[indexfunc][ IT[ A[c_, c_, d_], TI[{c_}, {d_}]] ],
            TestID -> "Structual equivalence: Tensor"
        ],
        
        VerificationTest[
            ScT[indexfunc] @ ScT[indexfunc][ IS[ A[a_, a_, b_], SI[{a_}, {b_}]] ],
            ScT[indexfunc][ IS[ A[d_, d_, c_], SI[{c_}, {d_}]] ],
            TestID -> "Consistency of repeated transformation"
        ]
    }
]    
]


End[];
