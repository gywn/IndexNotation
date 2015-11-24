(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["IndexSum.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            IS[A, SI[]], A,
            TestID -> "IndexSum -- identity_1"
        ],
        
        VerificationTest[
            IS[A], A,
            TestID -> "IndexSum -- identity_2"
        ],
    
        VerificationTest[
            IS[A,{a_},{b_},{c_}],
            IS[IS[IS[A, SI[{DI[1]}]], SI[{DI[2]}]], SI[{DI[3]}]],
            TestID -> "IndexSum -- gammar sugar"
        ],
    
        VerificationTest[
            IS[A,{a_},{a_},{c_}],
            Hold @ IS[A,{a_},{a_},{c_}],
            TestID -> "IndexSum -- failed gammar sugar"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                IS[a, b] = IS[ A[i_, j_], SI[ {i_}, {j_} ] ];
                {a, b}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ] },
            TestID -> "IndexTensor -- direct unpacking assignement"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                IS[a, b] = A[i_, j_];
                {a, b}
            ],
            { A[i_, j_], SI[] },
            TestID -> "IndexTensor -- direct unpacking assignement, empty sum"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                IS[a, b, c] = IS[ A[i_, j_], SI[ {i_}, {j_} ] ];
                {a, b, c}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ] },
            TestID -> "IndexTensor -- direct unpacking assignement, empty option"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                IS[a, b, c] = IS[ A[i_, j_], SI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 ];
                {a, b, c}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 },
            TestID -> "IndexTensor -- direct unpacking assignement, several options"
        ],
        
        VerificationTest[
            N @ IS[ a[i_, 3/2], SI[ {i_, 4} ] ],
            IS[ a[i_, 1.5], SI[ {i_, 4} ] ],
            TestID -> "N"
        ]
    }
]


End[];
