(* ::Package:: *)

TestList = {
    "SymbolicTensorDev/unit/test/SymbolicTensor.m",
    "SymbolicTensorDev/unit/test/SymbolicSum.m",
    
    "SymbolicTensorDev/unit/test/QuotientStructure/Order.m",
    "SymbolicTensorDev/unit/test/QuotientStructure/OrderedQ.m",
    "SymbolicTensorDev/unit/test/QuotientStructure/SameQ.m",
    "SymbolicTensorDev/unit/test/QuotientStructure/Sort.m",
    "SymbolicTensorDev/unit/test/QuotientStructure/Split.m",
    
    "SymbolicTensorDev/unit/test/Utility/DumbIndexList.m",
    "SymbolicTensorDev/unit/test/Utility/FreeMemberQ.m",
    "SymbolicTensorDev/unit/test/Utility/OccurrenceSequence.m",
    "SymbolicTensorDev/unit/test/Utility/PatternPresentQ.m",
    "SymbolicTensorDev/unit/test/Utility/UnionPartition.m",
    
    "SymbolicTensorDev/unit/test/Scope/Replace.m",
    "SymbolicTensorDev/unit/test/Scope/Yield.m",
    "SymbolicTensorDev/unit/test/Scope/Transform.m",
    "SymbolicTensorDev/unit/test/Scope/UniqueIndex.m",
    
    "SymbolicTensorDev/unit/test/transform_rules/m-t.m",
    "SymbolicTensorDev/unit/test/transform_rules/p-t.m",
    "SymbolicTensorDev/unit/test/transform_rules/s-t.m",
    "SymbolicTensorDev/unit/test/transform_rules/s-m-p.m",
    "SymbolicTensorDev/unit/test/transform_rules/s-p.m",
    "SymbolicTensorDev/unit/test/transform_rules/s-m-s.m",
    "SymbolicTensorDev/unit/test/transform_rules/mixed.m",
    
    "SymbolicTensorDev/unit/test/transform_rules/t-t.m",
    "SymbolicTensorDev/unit/test/transform_rules/s-s.m",
    "SymbolicTensorDev/unit/test/transform_rules/s-m.m",
    "SymbolicTensorDev/unit/test/transform_rules/mixed-2.m",
    
    "SymbolicTensorDev/unit/test/SymbolicSimplify/ReduceEmptySum.m",
    "SymbolicTensorDev/unit/test/SymbolicSimplify/LeafCount.m"
};

(path \[Function] Block[
    { tests = Get[path] },
    
    ( test \[Function] If[ test["Outcome"] =!= "Success", Print[path, ": ", test] ] )
        /@ If[ MatchQ[ tests, _List], tests, {tests} ]
]) /@ TestList;
