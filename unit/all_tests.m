(* ::Package:: *)

TestList = {
    "IndexNotation/unit/test/IndexTensor.m",
    "IndexNotation/unit/test/IndexSum.m",
    
    "IndexNotation/unit/test/Utility/Order.m",
    "IndexNotation/unit/test/Utility/OrderedQ.m",
    "IndexNotation/unit/test/Utility/SameQ.m",
    "IndexNotation/unit/test/Utility/Sort.m",
    "IndexNotation/unit/test/Utility/Gather.m",
    
    "IndexNotation/unit/test/Utility/FreeMemberQ.m",
    "IndexNotation/unit/test/Utility/SortedIndex.m",
    "IndexNotation/unit/test/Utility/PatternPresentQ.m",
    "IndexNotation/unit/test/Utility/UnionPartition.m",
    
    "IndexNotation/unit/test/Scope/DummyIndexList.m",
    "IndexNotation/unit/test/Scope/Transform.m",
    "IndexNotation/unit/test/Scope/UniqueIndex.m",
    
    "IndexNotation/unit/test/IndexFlatten.m",
    
    "IndexNotation/unit/test/transform_rules/m-t.m",
    "IndexNotation/unit/test/transform_rules/p-t.m",
    "IndexNotation/unit/test/transform_rules/s-t.m",
    "IndexNotation/unit/test/transform_rules/s-m-p.m",
    "IndexNotation/unit/test/transform_rules/s-p.m",
    "IndexNotation/unit/test/transform_rules/s-m-s.m",
    "IndexNotation/unit/test/transform_rules/mixed.m",
    
    "IndexNotation/unit/test/transform_rules/t-t.m",
    "IndexNotation/unit/test/transform_rules/s-s.m",
    "IndexNotation/unit/test/transform_rules/s-m.m",
    "IndexNotation/unit/test/transform_rules/mixed-2.m",
    
    "IndexNotation/unit/test/transform_rules/s-d.m",
    "IndexNotation/unit/test/transform_rules/s-sd.m",
    "IndexNotation/unit/test/transform_rules/t-sd.m",
    
    "IndexNotation/unit/test/operation/Part.m",
    "IndexNotation/unit/test/operation/TensorProduct.m",
    "IndexNotation/unit/test/operation/TensorContract.m",
    "IndexNotation/unit/test/operation/TensorTranspose.m",
    "IndexNotation/unit/test/operation/DotProduct.m",
    "IndexNotation/unit/test/operation/Tr.m",
    "IndexNotation/unit/test/DoubleContract.m",
    "IndexNotation/unit/test/TensorDerivative.m"
};

Block[
    {time, count}, 

    {time, count} = AbsoluteTiming[ ( path \[Function] (
        Get[path]; (* Write to Global`RESULTS *)
        
        ( result \[Function]  If[ result["Outcome"] =!= "Success", Print[path, "\n", result] ] )
            /@ If[ MatchQ[ RESULTS, _List], RESULTS, {RESULTS} ]
    ) ) /@ TestList ];

    Print["Used Time: ", time, " seconds\nRun Tests: ", Length @ Flatten @ count];
]
