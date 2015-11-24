(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Scope/DummyIndexList.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        ScL = IndexNotation`Scope`DummyIndexList
    },
    
    Global`RESULTS = {
        VerificationTest[
            ScL[ IT[0, TI[ {c_}, {b_}, {a_} ]], {} ],
            {a_, b_, c_},
            TestID -> "simple tensor case 1"
        ],
    
        VerificationTest[
            ScL[ IS[A[c_,b_], SI[ {d_}, {b_}, {c_}, {a_} ]], {} ],
            {c_, b_, a_, d_},
            TestID -> "simple sum case 1"
        ],
    
        VerificationTest[
            ScL[ IS[ IS[ A[i_, j_], SI[{i_}] ][ B[i_] ], SI[{i_}, {j_}] ], {} ],
            {j_, i_},
            TestID -> "simple case"
        ],
        
        VerificationTest[
            ScL[ IS[ IS[ A[i_, k_], SI[{i_}] ] IS[ A[k_, j_], SI[{k_}] ], SI[{i_}, {j_,4}, {k_,3}] ], {} ],
            {k_, j_, i_},
            TestID -> "shadowing of internal dummy index 1"
        ],
        
        VerificationTest[
            ScL[ IS[ IS[ A[i_, k_], SI[{i_}] ] IS[ A[k_, j_], SI[{k_}] ], SI[{i_,3}, {j_,4}, {k_,3}] ], {} ],
            {k_, j_, i_},
            TestID -> "shadowing of internal dummy index 2"
        ],
        
        VerificationTest[
            ScL[ IS[ IS[ A[j_, a_], SI[{a_}] ] IS[ A[i_, b_], SI[{b_}] ], SI[{i_,3}, {j_,3}] ], {} ],
            {j_, i_},
            TestID -> "totally determinated by internal dummy index"
        ],
        
        VerificationTest[
            ScL[ IS[ IS[ A[j_, a_], SI[{a_}] ] IS[ A[i_, a_], SI[{a_}] ], SI[{i_,3}, {j_,3}] ], {} ],
            {i_, j_},
            TestID -> "fall back to explicit comparing"
        ],
        
        VerificationTest[
            ScL[ IS[ A[j_,k_,i_]+A[l_,j_,k_], SI[{i_,3}, {l_,4}] ], {j_,k_} ],
            {i_, l_},
            TestID -> "classical exterior dummy index 1"
        ],
        
        VerificationTest[
            ScL[ IS[ A[j_,k_,l_]+A[i_,j_,i_], SI[{i_,3}, {l_,4}] ], {j_, k_} ],
            {l_, i_},
            TestID -> "classical exterior dummy index 2"
        ],
        
        VerificationTest[
            ScL[ IS[ SI[i_,k_,k_] + SI[j_,l_,k_], SI[{i_}, {j_}] ], {k_, l_} ],
            {j_, i_},
            TestID -> "exterior dummy index: totally determinated by exterior"
        ],
        
        VerificationTest[
            ScL[ IS[ SI[j_,k_,k_] + SI[i_,l_,l_], SI[{i_}, {j_}] ], {k_, l_} ],
            {j_, i_},
            TestID -> "exterior dummy indices: fall back to explicit comparing"
        ]
    }
]


End[];
