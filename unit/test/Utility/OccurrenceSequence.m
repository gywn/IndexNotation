(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["Utility/OccurrenceSequence.m"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        sql = SymbolicTensor`Utility`OccurrenceSequence`Sequential,
        sml = SymbolicTensor`Utility`OccurrenceSequence`Simultaneous,
        CoS = SymbolicTensor`Utility`OccurrenceSequence`ComplexSequence,
        
        OcS = SymbolicTensor`Utility`OccurrenceSequence
    },
    
    {
        VerificationTest[
            CoS[SS[A[i,4]+A[j,3],SI[{i},{j}]], {i,j}],
            Sequence[],
            TestID -> "ComplexSequence -- no occurrence"
        ],
        
        VerificationTest[
            CoS[A[i,4]+A[j,3], {i,j}],
            sql[j,i],
            TestID -> "ComplexSequence -- orderless yet sequential"
        ],
        
        VerificationTest[
            CoS[A[i,3]+A[j,3], {i,j}],
            sql[sml[sql[j],sql[i]]],
            TestID -> "ComplexSequence -- orderless and simultaneous"
        ],
        
        VerificationTest[
            CoS[A[i,3]+A[j,3]+A[i,4], {i,j}],
            sql[sml[sql[j],sql[i]],i],
            TestID -> "ComplexSequence -- orderless and mixed"
        ],
        
        VerificationTest[
            OcS[ F[c,G[a,b]+G[c,d],a], {a,b,c,d} ] - {c,d,a,b},
            OcS[ F[c,G[a,d]+G[c,b],a], {a,b,c,d} ] - {c,b,a,d},
            TestID -> "OccurrenceSequence -- differentiating Orderless terms"
        ],
        
        VerificationTest[
            OcS[ SS[A[a,b],SI[{a}]], {a, b} ],
            {b},
            TestID -> "OccurrenceSequence -- shadowing + only one index"
        ],
        
        VerificationTest[
            OcS[ ST[A[a_,b_,b_],TI[{a_}]], {a_, b_, c_} ],
            {b_},
            TestID -> "OrderedFreeMemberList -- shadowing + pattern index + duplicated occurrence"
        ],
        
        VerificationTest[
            OcS[ {a+b,SI[{a,4},{b,3}]}, {a,b} ],
            {b,a},
            TestID -> "OccurrenceSequence -- classical case 1"
        ],
        
        VerificationTest[
            OcS[ {a+b,TI[{a,4},{b,3}]}, {a,b} ],
            {a,b},
            TestID -> "OccurrenceSequence -- classical case 2"
        ],
        
        VerificationTest[
            OcS[ a, {a,b,c} ],
            {a},
            TestID -> "OccurrenceSequence -- single occurrence"
        ],
        
        VerificationTest[
            OcS[ d, {a,b,c} ],
            {},
            TestID -> "OccurrenceSequence -- no occurrence"
        ],
        
        VerificationTest[
            OcS[ A[a b] + B[c, b] + B[d, a], {a,b,c,d} ],
            {a,b,d,c},
            TestID -> "KNOWN BUG: Multiple-orderless choices"
        ],
        
        VerificationTest[
            OcS[ {A[a,b] B[c d] C[b, c] C[a, d]}, {a,b,c,d} ],
            {a,b,d,c},
            TestID -> "pure internal coupled indexes"
        ],
        
        VerificationTest[
            OcS[ {A[a b] B[a, d] B[b, c]}, {a,b}, {c,d} ] - {b,a},
            OcS[ {A[a b] B[b, d] B[a, c]}, {a,b}, {c,d} ] - {a,b},
            TestID -> "mixed coupled indexes: external has priority"
        ],
        
        VerificationTest[
            OcS[ A[e f] A[f g] A[g e] A[a b] A[b c] A[c d] A[d a], {a,b,c,d,e,f,g} ] - {e,f,g,a,b,d,c},
            OcS[ A[a b] A[b c] A[c a] A[d e] A[e f] A[f g] A[g d], {a,b,c,d,e,f,g} ] - {a,b,c,d,e,g,f},
            TestID -> "KNOWN BUG: Multiple-orderless choices"
        ]
    }
]
