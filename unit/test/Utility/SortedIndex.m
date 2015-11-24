(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Utility/SortedIndex.m"];


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        sql = IndexNotation`Utility`SortedIndex`Sequential,
        sml = IndexNotation`Utility`SortedIndex`Simultaneous,
        CoS = IndexNotation`Utility`SortedIndex`ComplexSequence,
        
        SrI = IndexNotation`Utility`SortedIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            CoS[IS[A[i,4]+A[j,3],SI[{i},{j}]], {i,j}],
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
            SrI[ F[c,G[a,b]+G[c,d],a], {a,b,c,d} ] - {c,d,a,b},
            SrI[ F[c,G[a,d]+G[c,b],a], {a,b,c,d} ] - {c,b,a,d},
            TestID -> "SortedIndex -- differentiating Orderless terms"
        ],
        
        VerificationTest[
            SrI[ IS[A[a,b],SI[{a}]], {a, b} ],
            {b},
            TestID -> "SortedIndex -- shadowing + only one index"
        ],
        
        VerificationTest[
            SrI[ IT[A[a_,b_,b_],TI[{a_}]], {a_, b_, c_} ],
            {b_},
            TestID -> "OrderedFreeMemberList -- shadowing + pattern index + duplicated occurrence"
        ],
        
        VerificationTest[
            SrI[ {a+b,SI[{a,4},{b,3}]}, {a,b} ],
            {b,a},
            TestID -> "SortedIndex -- classical case 1"
        ],
        
        VerificationTest[
            SrI[ {a+b,TI[{a,4},{b,3}]}, {a,b} ],
            {a,b},
            TestID -> "SortedIndex -- classical case 2"
        ],
        
        VerificationTest[
            SrI[ a, {a,b,c} ],
            {a},
            TestID -> "SortedIndex -- single occurrence"
        ],
        
        VerificationTest[
            SrI[ d, {a,b,c} ],
            {},
            TestID -> "SortedIndex -- no occurrence"
        ],
        
        VerificationTest[
            SrI[ A[a b] + B[c, b] + B[d, a], {a,b,c,d} ],
            {a,b,d,c},
            TestID -> "KNOWN BUG: Multiple-orderless choices"
        ],
        
        VerificationTest[
            SrI[ {A[a,b] B[c d] C[b, c] C[a, d]}, {a,b,c,d} ],
            {a,b,d,c},
            TestID -> "pure internal coupled indices"
        ],
        
        VerificationTest[
            SrI[ {A[a b] B[a, d] B[b, c]}, {a,b}, {c,d} ] - {b,a},
            SrI[ {A[a b] B[b, d] B[a, c]}, {a,b}, {c,d} ] - {a,b},
            TestID -> "mixed coupled indices: external has priority"
        ],
        
        VerificationTest[
            SrI[ A[e f] A[f g] A[g e] A[a b] A[b c] A[c d] A[d a], {a,b,c,d,e,f,g} ] - {e,f,g,a,b,d,c},
            SrI[ A[a b] A[b c] A[c a] A[d e] A[e f] A[f g] A[g d], {a,b,c,d,e,f,g} ] - {a,b,c,d,e,g,f},
            TestID -> "KNOWN BUG: Multiple-orderless choices"
        ]
    }
]


End[];
