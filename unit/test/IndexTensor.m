(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["IndexTensor.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            IT[A, TI[]], A,
            TestID -> "IndexTensor -- identity_1"
        ],
        
        VerificationTest[
            IT[A], A,
            TestID -> "IndexTensor -- identity_2"
        ],
    
        VerificationTest[
            IT[A,{a_},{b_},{c_}],
            IT[IT[IT[A, TI[{DI[1]}]], TI[{DI[2]}]], TI[{DI[3]}]],
            TestID -> "IndexTensor -- gammar sugar"
        ],

        VerificationTest[
            IT[A,{a_},{a_},{c_}],
            Hold @ IT[A,{a_},{a_},{c_}],
            TestID -> "IndexTensor -- failed gammar sugar"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                IT[a, b] = IT[ A[i_, j_], TI[ {i_}, {j_} ] ];
                {a, b}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ] },
            TestID -> "IndexTensor -- direct unpacking assignement"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                IT[a, b] = A[i_, j_];
                {a, b}
            ],
            { A[i_, j_], TI[] },
            TestID -> "IndexTensor -- direct unpacking assignement, empty tensor"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                IT[a, b, c] = IT[ A[i_, j_], TI[ {i_}, {j_} ] ];
                {a, b, c}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ] },
            TestID -> "IndexTensor -- direct unpacking assignement, empty option"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                IT[a, b, c] = IT[ A[i_, j_], TI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 ];
                {a, b, c}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 },
            TestID -> "IndexTensor -- direct unpacking assignement, several options"
        ],
        
        VerificationTest[
            N @ IT[ a[i_, 3/2], TI[ {i_, 4} ] ],
            IT[ a[i_, 1.5], TI[ {i_, 4} ] ],
            TestID -> "N"
        ]
    }
]


End[];
