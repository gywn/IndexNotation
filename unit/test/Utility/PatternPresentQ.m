(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Utility/PatternPresentQ.m"];


Begin["IndexNotation`test`"];


With[
    {PPQ = IndexNotation`Utility`PatternPresentQ},
    
    Global`RESULTS = {
        VerificationTest[
            PPQ @ Verbatim[m_],
            False,
            TestID -> "PatternPresentQ -- avoid Verbatim"
        ],
    
        VerificationTest[
            PPQ[_] \[And] PPQ[m_] \[And] PPQ[m_ /; m > 2] \[And] PPQ[m_ ? OddQ] \[And] PPQ[m_ | n_],
            True,
            TestID -> "PatternPresentQ -- behave as default"
        ]
    }
]


End[];
