(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-d.m"]


With[
    {
        KD = KroneckerDelta,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        DI = SymbolicTensor`DumbIndex
    },
    
    {
        VerificationTest[
            SS[ KD[i_, i_, j_] , SI[ {i_, 3}, {j_, 4} ] ],
            Hold @ SS[ KD[i_, i_, j_] , SI[ {i_, 3}, {j_, 4} ] ],
            TestID -> "incompatible index order"
        ],
        
        VerificationTest[
            SS[ KD[i_, i_, j_] , SI[ {i_, 3}, {j_, 3} ] ],
            SS[ 1 , SI[ {DI[1], 3} ] ],
            TestID -> "incompatible index order"
        ],
        
        VerificationTest[
            SS[ KD[i_, j_, L_] KD[k_, M_] A[i_, j_, k_] B[k_], SI[ {i_, 3}, {j_, 3}, {k_, 5} ] ],
            A[L_, L_, M_] B[M_],
            TestID -> "external index + extra term"
        ],
        
        VerificationTest[
            SS[ KD[i_, j_, L_] A[i_, j_] SS[ B[i_], SI[{i_}] ], SI[ {i_}, {j_} ] ],
            A[L_, L_] SS[ B[DI[1]], SI[{DI[1]}] ],
            TestID -> "external index + extra term (internal dumb index)"
        ],
        
        VerificationTest[
            SS[ KD[i_, j_, L_] KD[k_, M_], SI[ {i_, 3}, {j_, 3}, {k_, 5} ] ],
            1,
            TestID -> "external index + only Kronecker delta product"
        ],
        
        VerificationTest[
            SS[ KD[i_, j_, L_]^3 KD[k_, M_] A[i_, j_, k_] B[k_], SI[ {i_, 3}, {j_, 3}, {k_, 5} ] ],
            A[L_, L_, M_] B[M_],
            TestID -> "external index + extra term + power"
        ],
        
        VerificationTest[
            SS[ KD[i_, j_, L_] KD[k_, M_]^3, SI[ {i_, 3}, {j_, 3}, {k_, 5} ] ],
            1,
            TestID -> "external index + only Kronecker delta product"
        ],
        
        VerificationTest[
            SS[ KD[i_, j_] KD[k_, M_], SI[ {i_, 3}, {j_, 3}, {k_, 4} ] ],
            SS[ 1, SI[{DI[1], 3}] ],
            TestID -> "mixed internal/external Kronecker delta product"
        ],
        
        VerificationTest[
            SS[ KD[i_, j_] KD[k_, M_] SS[ A[i_, j_, k_], SI[{i_}] ], SI[ {i_, 3}, {j_, 3}, {k_, 4} ] ],
            SS[ SS[ A[DI[1], DI[2], M_], SI[{DI[1]}] ], SI[{DI[2], 3}] ],
            TestID -> "mixed internal/external Kronecker delta + extra terms (dumb index)"
        ],
        
        VerificationTest[
            SS[ KD[i_, j_]^2 KD[k_, M_]^2 SS[ A[i_, j_, k_], SI[{i_}] ], SI[ {i_, 3}, {j_, 3}, {k_, 4} ] ],
            SS[ SS[ A[DI[1], DI[2], M_], SI[{DI[1]}] ], SI[{DI[2], 3}] ],
            TestID -> "mixed internal/external Kronecker delta + extra terms (dumb index) + power"
        ]
    }
]
