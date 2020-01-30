let src = ./src/spago.dhall

let test = ./test/spago.dhall

let example = ./example/spago.dhall

in  { name =
        "baseweb-all"
    , dependencies =
        src.dependencies # test.dependencies # example.dependencies
    , packages =
        ./packages.dhall
    , sources =
        src.sources # test.dependencies # example.dependencies
    }
