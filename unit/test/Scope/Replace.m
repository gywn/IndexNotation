(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet[
    "Scope/Replace.m",
    "Scope/Transform.m"
]


With[
    {
    	ST = SymbolicTensor`SymbolicTensor,
    	TI = SymbolicTensor`TensorIndex,
    	
    	SS = SymbolicTensor`SymbolicSum,
    	SI = SymbolicTensor`SumIndex,
    	
    	ScR = SymbolicTensor`Scope`Replace,
    	ScT = SymbolicTensor`Scope`Transform
    },
    
Block[
    {indexfunc},
    
    indexfunc[i_] := Idx[i];
    {
        VerificationTest[
            ScR[
                ST[ a[i_], TI[{i_}] ] b[i_], 
                Verbatim[i_] :> j_
            ],
            ST[a[i_], TI[{i_}]] b[j_],
            TestID -> "Simple internal dumb index shadowing 1: Tensor"
        ],
        
        VerificationTest[
            ScR[
                SS[ a[i_], SI[{i_}] ] b[i_], 
                Verbatim[i_] :> j_
            ],
            SS[a[i_], SI[{i_}]] b[j_],
            TestID -> "Simple internal dumb index shadowing 1"
        ],
            
        VerificationTest[
            ScR[
                SS[ a[i_], SI[{i_}] ] b[i_], 
                Verbatim[i_] :> i
            ],
            SS[a[i_], SI[{i_}]] b[i],
            TestID -> "Simple internal dumb index shadowing 2"
        ],
            
        VerificationTest[
            ScT[indexfunc] @ ScR[
                SS[ a[i_] ~OP~ c[j_], SI[{i_}] ] b[i_] d[j_], 
                {
                    Verbatim[i_] :> j_,
                    Verbatim[j_] :> i_
                }
            ],
            SS[a[Idx[1]] ~OP~ c[i_], SI[{Idx[1]}]] b[j_] d[i_],
            TestID -> "Complex internal dumb index shadowing + transform 1"
        ],
            
        VerificationTest[
            ScT[indexfunc] @ ScR[
                SS[ a[i_, j_] ~OP~ b[k_,l_,m_], SI[{i_}, {j_}, {m_}]],
                {
                    Verbatim[k_] :> i_,
                    Verbatim[l_] :> j_,
                    Verbatim[m_] :> k_
                }
            ],
            SS[ a[Idx[1], Idx[2]] ~OP~ b[i_, j_, Idx[3]], SI[{Idx[1]}, {Idx[2]}, {Idx[3]}]],
            TestID -> "Complex internal dumb index shadowing + transform 2"
        ]
    }
]    
]
