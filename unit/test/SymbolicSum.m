(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["SymbolicSum.m"]


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        DI = SymbolicTensor`DumbIndex
    },
    
    {
        VerificationTest[
            SS[A, SI[]], A,
            TestID -> "SymbolicSum -- identity_1"
        ],
        
        VerificationTest[
            SS[A], A,
            TestID -> "SymbolicSum -- identity_2"
        ],
    
        VerificationTest[
            SS[A,{a_},{b_},{c_}],
            SS[SS[SS[A, SI[{DI[1]}]], SI[{DI[2]}]], SI[{DI[3]}]],
            TestID -> "SymbolicSum -- gammar sugar"
        ],
    
        VerificationTest[
            SS[A,{a_},{a_},{c_}],
            Hold @ SS[A,{a_},{a_},{c_}],
            TestID -> "SymbolicSum -- failed gammar sugar"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                SS[a, b] = SS[ A[i_, j_], SI[ {i_}, {j_} ] ];
                {a, b}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ] },
            TestID -> "SymbolicTensor -- direct unpacking assignement"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                SS[a, b] = A[i_, j_];
                {a, b}
            ],
            { A[i_, j_], SI[] },
            TestID -> "SymbolicTensor -- direct unpacking assignement, empty sum"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                SS[a, b, c] = SS[ A[i_, j_], SI[ {i_}, {j_} ] ];
                {a, b, c}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ] },
            TestID -> "SymbolicTensor -- direct unpacking assignement, empty option"
        ],

        VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                SS[a, b, c] = SS[ A[i_, j_], SI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 ];
                {a, b, c}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 },
            TestID -> "SymbolicTensor -- direct unpacking assignement, several options"
        ],
        
        VerificationTest[
            N @ SS[ a[i_, 3/2], SI[ {i_, 4} ] ],
            SS[ a[i_, 1.5], SI[ {i_, 4} ] ],
            TestID -> "N"
        ]
    }
]



