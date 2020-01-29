module Test.BaseUI.Button where

import Prelude
import BaseUI (defaultOverride)
import BaseUI.Button (button)
import BaseUI.Button as BaseUI
import BaseUI.Button as Button
import Effect (Effect)
import React as React
import React.DOM as DOM
import ReactDOM (renderToString)
import Record (union)
import Test.Unit (TestSuite, test)
import Test.Unit.QuickCheck (quickCheck)
import Unsafe.Coerce (unsafeCoerce)

checkButton :: TestSuite
checkButton = do
  test "Button" do
    quickCheck \( props' ::
        { disabled :: Boolean
        , isLoading :: Boolean
        , isSelected :: Boolean
        , kind :: Button.Kind
        , shape :: Button.Shape
        , size :: Button.Size
        , type :: Button.Type
        }
    ) ->
      let
        (props :: BaseUI.ButtonProps) =
          props'
            `union`
              { children: unsafeCoerce []
              , endEnhancer: const $ DOM.text ""
              , startEnhancer: const $ DOM.text ""
              , onClick: (pure unit) :: Effect Unit
              -- TODO
              , overrides: { baseButton: defaultOverride }
              }

        _ = renderToString $ React.createLeafElement button props
      in
        true
