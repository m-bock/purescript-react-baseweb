{ name =
    "react-baseweb-test"
, license =
    "MIT"
, dependencies =
    [ "console"
    , "effect"
    , "partial"
    , "psci-support"
    , "react"
    , "quickcheck"
    , "test-unit"
    , "react-dom"
    ]
, packages =
    ../packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
