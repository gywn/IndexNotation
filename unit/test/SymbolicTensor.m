(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["SymbolicTensor.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        DI = SymbolicTensor`DumbIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            ST[A, TI[]], A,
            TestID -> "SymbolicTensor -- identity_1"
        ],
        
        VerificationTest[
            ST[A], A,
            TestID -> "SymbolicTensor -- identity_2"
        ],
    
        VerificationTest[
            ST[A,{a_},{b_},{c_}],
            ST[ST[ST[A, TI[{DI[1]}]], TI[{DI[2]}]], TI[{DI[3]}]],
            TestID -> "SymbolicTensor -- gammar sugar"
        ],

        VerificationTest[
            ST[A,{a_},{a_},{c_}],
            Hold @ ST[A,{a_},{a_},{c_}],
            TestID -> "SymbolicTensor -- failed gammar sugar"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                ST[a, b] = ST[ A[i_, j_], TI[ {i_}, {j_} ] ];
                {a, b}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ] },
            TestID -> "SymbolicTensor -- direct unpacking assignement"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                ST[a, b] = A[i_, j_];
                {a, b}
            ],
            { A[i_, j_], TI[] },
            TestID -> "SymbolicTensor -- direct unpacking assignement, empty tensor"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                ST[a, b, c] = ST[ A[i_, j_], TI[ {i_}, {j_} ] ];
                {a, b, c}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ] },
            TestID -> "SymbolicTensor -- direct unpacking assignement, empty option"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                ST[a, b, c] = ST[ A[i_, j_], TI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 ];
                {a, b, c}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 },
            TestID -> "SymbolicTensor -- direct unpacking assignement, several options"
        ],
        
        VerificationTest[
            N @ ST[ a[i_, 3/2], TI[ {i_, 4} ] ],
            ST[ a[i_, 1.5], TI[ {i_, 4} ] ],
            TestID -> "N"
        ]
    }
]


End[];
