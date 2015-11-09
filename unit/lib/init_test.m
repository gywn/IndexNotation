(* ::Package:: *)

With[
    {
        packageDir = "SymbolicTensorDev",
        packageContext = "SymbolicTensor"
    },

    Quiet[
        (con \[Function] Remove @ Evaluate @ StringJoin[con, "*"]) /@ Contexts[packageContext <> "*"],
        {Remove::rmnsm, Remove::rmptc}
        (* Message: no symbol matched & protected symbol *)
    ];

    RecursiveGet[ s__ ] := Block[
        {cmd, packages},
        
        cmd = StringJoin @ Riffle[ Join[
            {"!", "~/workspace/mathematica/dep", "-d", packageDir, "-c", packageContext},
            "'" <> # <> "'" & /@ {s}
        ], " " ];
        packages = Import[cmd, {"Text", "Lines"}];

        Get[#]& /@ packages;

        (* Output all imported files *)
        Grid[ {#}& /@ packages, Alignment -> {Left, Baseline} ]
    ];
]
