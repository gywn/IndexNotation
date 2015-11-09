(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["Utility/UnionPartition.m"];


With[
    {
    	UP = SymbolicTensor`Utility`UnionPartition,
    	ES = SymbolicTensor`Utility`UnionPartition`EmptySum
    },
    
    VerificationTest[
    	Block[
    		{ rpl = UP[
    			{{i_,j_},{j_,k_},{l_,m_},{m_,n_},{}},
    			{i_,j_,k_,l_,m_,n_,o_,p_}
    		]},
    		
    		GatherBy[ {i_,j_,k_,l_,m_,n_,o_,p_}, # //. rpl & ]
    	],
    	{{i_,j_,k_},{l_,m_,n_},{o_,p_}},
    	TestID -> "UnionPartition -- unused index"
    ]
]
