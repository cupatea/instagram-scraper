import React, { useState } from 'react'
import Avatar from '@material-ui/core/Avatar'
import Button from '@material-ui/core/Button'
import TextField from '@material-ui/core/TextField'
import Link from '@material-ui/core/Link'
import Grid from '@material-ui/core/Grid'
import LockOutlinedIcon from '@material-ui/icons/LockOutlined'
import Typography from '@material-ui/core/Typography'
import CircularProgress from '@material-ui/core/CircularProgress'
import { makeStyles } from '@material-ui/core/styles'

const useStyles = makeStyles(theme => ({
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.secondary.main,
  },
  form: {
    width: '100%', // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
}))

export default function LoginForm({
  sendResetPasswordMessageFunction,
  resetPasswordFunction,
  resetPasswordMessageSent,
  loginPagePath,
  signUpPagePath,
  sendResetPasswordMessageLoading,
  resetPasswordLoading,
}) {
  const classes = useStyles()
  const [username, setUserame] = useState('')
  const [resetPasswordCode,setResetPasswordCode] = useState('')
  const [newPassword, setNewPassword] = useState('')

  function handleSendResetPasswordMessage(event) {
    event.preventDefault()
    sendResetPasswordMessageFunction({
      variables: {username}
    })

  }

  function handleSubmit(event) {
    event.preventDefault()
    resetPasswordFunction({
      variables: {
        username,
        newPassword,
        resetPasswordCode,
      }
    })
  }

  return (
    <React.Fragment>
      <Avatar className={classes.avatar}>
        <LockOutlinedIcon />
      </Avatar>
      <Typography component="h1" variant="h5">
        Reset password
      </Typography>
      <form
        className={classes.form}
        noValidate
        onSubmit = { (event) => handleSubmit(event) }
      >

        <TextField
          variant="outlined"
          margin="normal"
          required
          fullWidth
          id="username"
          label="Instagram Username"
          name="username"
          disabled = {resetPasswordMessageSent}
          autoFocus
          onChange = { event => setUserame(event.target.value) }
        />
        { !resetPasswordMessageSent &&
            <Button
              onClick = {(e) => handleSendResetPasswordMessage(e) }
              fullWidth
              variant="contained"
              color="primary"
              className={classes.submit}
            >
            {
              sendResetPasswordMessageLoading
                ? <CircularProgress size={24} color="secondary"/>
                : 'Send rest password code'
            }
            </Button>
        }


        { resetPasswordMessageSent &&
           <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="reset-password-code"
            label="Reset password code"
            name="reset-password-code"
            onChange = { event => setResetPasswordCode(event.target.value) }
          />
        }
        {
          resetPasswordMessageSent &&
            <TextField
              variant="outlined"
              margin="normal"
              required
              fullWidth
              name="new-password"
              label="New password"
              type="password"
              id="password"
              autoComplete="new-password"
              disabled = {!resetPasswordMessageSent}
              onChange = { event => setNewPassword(event.target.value) }
            />
        }

        { resetPasswordMessageSent &&
            <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            className={classes.submit}
          >
          {
            resetPasswordLoading
              ? <CircularProgress size={24} color="secondary"/>
              : 'Reset password'
          }
          </Button>
      }
        <Grid container>
          <Grid item xs>
            <Link href={loginPagePath} variant="body2">
              Login with credentials
            </Link>
          </Grid>
          <Grid item>
            <Link href={signUpPagePath} variant="body2">
              {"Don't have an account? Sign Up"}
            </Link>
          </Grid>
        </Grid>
      </form>
    </React.Fragment>
  )
}
