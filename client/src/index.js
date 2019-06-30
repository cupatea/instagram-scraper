import React from 'react'
import ReactDOM from 'react-dom'

import {Provider, Router} from './components'

ReactDOM.render(
  <Provider>
    <Router />
  </Provider>,
  document.querySelector('#root'),
)
