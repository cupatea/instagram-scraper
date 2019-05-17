import React from 'react';
import CssBaseline from '@material-ui/core/CssBaseline'
import Container from '@material-ui/core/Container'
import { makeStyles } from '@material-ui/core/styles'
import { Message } from '.'
import {useSpring, animated} from 'react-spring'

const useStyles = makeStyles(theme => ({
  '@global': {
    body: {
      backgroundColor: theme.palette.common.white,
    },
  },
  paper: {
    marginTop: theme.spacing(8),
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  }
}))

export default function PageContainer({messages=[], children}) {
  const classes = useStyles()
  const transition = useSpring({opacity: 1, from:{opacity: 0}})
  return (
    <animated.div style={transition} >
      <Container component="main" maxWidth="xs">
        <CssBaseline />
        <div className={classes.paper}>
          {children}
          {messages.map(message => <Message key={message.content+message.id} content={message.content} />)}
        </div>
      </Container>
    </animated.div>
  )
}
