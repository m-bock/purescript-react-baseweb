# purescript-baseweb

[![Build Status](https://travis-ci.org/thought2/purescript-react-baseweb.svg?branch=master)](https://travis-ci.org/thought2/purescript-react-baseweb)

PureScript wrapper for [Base Web React Components](https://baseweb.design/components/).

Uses Version `v9.49.2`

- [API docs on Pursuit](http://pursuit.purescript.org/packages/purescript-react-baseweb/)

## Installation

```bash
bower install purescript-react-baseweb
```

## Usage

```purescript

import BaseUI.Button as Button
[...]

wrapProvider = [...]

app :: ReactElement
app =
  React.createElement wrapProvider {}
    [ React.createElement button
        ( Button.defaultButtonProps
            { shape = Button.ShapePill
            , onClick = log "clicked!"
            }
        )
        [ VDOM.text "Hello" ]
    ]
```

See [examples](https://thought2.github.io/purescript-react-baseweb/simple.html) and their [sources](example) for more details.

### With `react-basic`

In a `react-basic` app you may want to define a helper function like:

```purescript
import React as React
import React.Basic as ReactBasic

toBasic ::
  forall props.
  React.ReactClass { | props } ->
  { | props } -> JSX
toBasic reactClass props =
  ReactBasic.element (unsafeCoerce reactClass) props
```

## Coverage

|                 | Component           | partly             | full |
| --------------- | ------------------- | ------------------ | ---- |
| **Inputs**      |
|                 | button              | :heavy_check_mark: |      |
|                 | button-group        |                    |      |
|                 | checkbox            |                    |      |
|                 | form-control        |                    |      |
|                 | input               |                    |      |
|                 | payment-card        |                    |      |
|                 | phone-input         |                    |      |
|                 | pin-code            |                    |      |
|                 | radio               |                    |      |
|                 | slider              |                    |      |
|                 | textarea            |                    |      |
| **Pickers**     |
|                 | file-uploader       |                    |      |
|                 | menu                |                    |      |
|                 | rating              |                    |      |
|                 | select              |                    |      |
| **Date & Time** |
|                 | datepicker          |                    |      |
|                 | time-picker         |                    |      |
|                 | timezone-picker     |                    |      |
| **Navigation**  |
|                 | breadcrumbs         |                    |      |
|                 | header-navigation   |                    |      |
|                 | link                |                    |      |
|                 | pagination          |                    |      |
|                 | side-nav            |                    |      |
|                 | tabs                |                    |      |
| **Content**     |
|                 | accordion           |                    |      |
|                 | avatar              |                    |      |
|                 | dnd-list            |                    |      |
|                 | layout-grid         |                    |      |
|                 | heading             |                    |      |
|                 | icon                |                    |      |
|                 | list                |                    |      |
|                 | tag                 |                    |      |
|                 | tree-view           |                    |      |
|                 | typography          |                    |      |
| **Tables**      |
|                 | table               |                    |      |
|                 | unstable-data-table |                    |      |
|                 | table-grid          |                    |      |
|                 | table-semantic      |                    |      |
| **Feedback**    |
|                 | notification        |                    |      |
|                 | progress-bar        |                    |      |
|                 | progress-steps      |                    |      |
|                 | spinner             |                    |      |
|                 | toast               |                    |      |
| **Surfaces**    |
|                 | card                |                    |      |
|                 | drawer              |                    |      |
|                 | modal               |                    |      |
|                 | popover             |                    |      |
|                 | tooltip             |                    |      |
| **Utility**     |
|                 | aspect-ratio-box    |                    |      |
|                 | base-provider       | :heavy_check_mark: |      |
|                 | block               |                    |      |
|                 | flex-grid           |                    |      |
|                 | layer               |                    |      |
|                 | use-styletron       |                    |      |
|                 | styled              |                    |      |
|                 | tokens              |                    |      |
|                 | unstable-a11y       |                    |      |

## LICENCE

Copyright 2020 Michael Bock

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this program. If not, see
<http://www.gnu.org/licenses/>.
