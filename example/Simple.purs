module Example.Simple where

import Prelude
import BaseUI (baseProvider, defaultBaseProviderProps')
import BaseUI.Button (Shape(..), button, defaultButtonProps')
import BaseUI.Button as Button
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Debug.Trace (spy)
import Effect (Effect)
import Effect.Class.Console (log)
import React (ReactClass, ReactElement)
import React as React
import React.DOM as VDOM
import ReactDOM (render)
import Record (delete, union)
import Styletron.EngineAtomic as EngineAtomic
import Styletron.React as Styletron
import Web.DOM.NonElementParentNode (getElementById) as DOM
import Web.HTML (window) as DOM
import Web.HTML.HTMLDocument (toNonElementParentNode) as DOM
import Web.HTML.Window (document) as DOM

wrapProvider :: ReactClass { children :: React.Children }
wrapProvider =
  React.statelessComponent \props ->
    React.createElement Styletron.provider
      { value: EngineAtomic.mkClient unit }
      [ React.createLeafElement baseProvider
          ( defaultBaseProviderProps'
              `union`
                { children: props.children }
          )
      ]

app :: ReactElement
app =
  React.createElement wrapProvider {}
    [ React.createElement button
        ( Button.defaultButtonProps'
            { shape = Button.ShapePill
            , onClick = log "clicked!"
            }
        )
        [ VDOM.text "Hello" ]
    ]

main :: Effect Unit
main = do
  window <- DOM.window
  document <- DOM.document window
  let
    node = DOM.toNonElementParentNode document
  maybeElement <- DOM.getElementById "app" node
  case maybeElement of
    Just element -> do
      _ <- render app element
      pure unit
    Nothing -> log "element not found"
