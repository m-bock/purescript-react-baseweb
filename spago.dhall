{ name = "baseweb"
, license = "MIT"
, repository = "github.com/thought2/purescript-baseweb"
, dependencies =
    [ "console"
    , "debug"
    , "effect"
    , "partial"
    , "psci-support"
    , "quickcheck"
    , "react"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
