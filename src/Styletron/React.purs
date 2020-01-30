module Styletron.React
  ( provider
  , ProviderProps
  ) where

import React (ReactClass)
import React as React
import Styletron.Engine (Engine)

foreign import providerImpl :: ReactClass ProviderProps

type ProviderProps
  = { value :: Engine
    , children :: React.Children
    }

provider :: ReactClass ProviderProps
provider = providerImpl
