import React from 'react';
import CssBaseline from '@material-ui/core/CssBaseline'
import { makeStyles } from '@material-ui/core/styles'
import { Message } from '.'

const useStyles = makeStyles(theme => ({
  root: {
    display: 'flex',
  },
}))

export default function PageContainer({messages=[], children}) {
  const classes = useStyles()

  return (
    <div className={classes.root} >
      <CssBaseline />
      {children}
      {messages.map(message => <Message key={message.content+message.id} content={message.content} />)}
    </div>
  )
}
