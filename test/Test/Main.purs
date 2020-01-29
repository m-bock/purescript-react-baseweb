module Test.Main where

import Prelude
import Effect (Effect)
import Test.BaseUI.Button (checkButton)
import Test.Unit.Main (runTest)

main :: Effect Unit
main =
  runTest do
    checkButton
