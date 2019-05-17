import React, {useState} from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Snackbar from '@material-ui/core/Snackbar'
import IconButton from '@material-ui/core/IconButton'
import CloseIcon from '@material-ui/icons/Close'

const useStyles = makeStyles(theme => ({
  close: {
    padding: theme.spacing(0.5),
  },
}))

export default function Message({content}) {
  const classes = useStyles()
  const [open, setOpen] = useState(true)

  function handleClose(event, reason) {
    if (reason === 'clickaway') return
    setOpen(false)
  }

  function renderActionButton() {
    return(
      <IconButton
        key="close"
        aria-label="Close"
        color="inherit"
        className={classes.close}
        onClick={handleClose}
      >
        <CloseIcon />
      </IconButton>
    )
  }

  return (
    <React.Fragment>
      <Snackbar
        anchorOrigin={{
          vertical: 'bottom',
          horizontal: 'left',
        }}
        open={open}
        autoHideDuration={6000}
        onClose={handleClose}
        ContentProps={{'aria-describedby': 'message-id'}}
        message={<span id="message-id">{content}</span>}
        action={renderActionButton()}
      />
    </React.Fragment>
  )
}
