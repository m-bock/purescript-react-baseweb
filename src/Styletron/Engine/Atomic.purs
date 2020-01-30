module Styletron.EngineAtomic where

import Prelude
import Styletron.Engine (Engine)

foreign import mkClient :: Unit -> Engine
