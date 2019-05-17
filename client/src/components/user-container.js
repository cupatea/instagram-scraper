import React from 'react';
import CssBaseline from '@material-ui/core/CssBaseline'
import { makeStyles } from '@material-ui/core/styles'
import { Message } from '.'
import {useSpring, animated} from 'react-spring'

const useStyles = makeStyles(theme => ({
  root: {
    display: 'flex',
  },
}))

export default function PageContainer({messages=[], children}) {
  const classes = useStyles()
  const transition = useSpring({opacity: 1, from:{opacity: 0}})
  return (
    <animated.div className={classes.root} style={transition} >
      <CssBaseline />
      {children}
      {messages.map(message => <Message key={message.content+message.id} content={message.content} />)}
    </animated.div>
  )
}
