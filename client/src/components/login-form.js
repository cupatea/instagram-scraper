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

export default function LoginForm({ loginFunction, signUpPagePath, loading }) {
  const classes = useStyles()
  const [username, setUserame] = useState('')
  const [password, setPassword] = useState('')

  function handleSubmit(event) {
    event.preventDefault()
    loginFunction({
      variables: {
        username,
        password
      }
    })
  }

  return (
    <React.Fragment>
      <Avatar className={classes.avatar}>
        <LockOutlinedIcon />
      </Avatar>
      <Typography component="h1" variant="h5">
        Log in
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
          autoFocus
          onChange = { event => setUserame(event.target.value) }
        />
        <TextField
          variant="outlined"
          margin="normal"
          required
          fullWidth
          name="password"
          label="Password"
          type="password"
          id="password"
          autoComplete="current-password"
          onChange = { event => setPassword(event.target.value) }
        />
        <Button
          type="submit"
          fullWidth
          variant="contained"
          color="primary"
          className={classes.submit}
        >
        {
          loading
          ? <CircularProgress size={24} color="secondary"/>
          : 'Log In'
        }
        </Button>
        <Grid container>
          <Grid item xs>
            <Link href="#" variant="body2">
              Forgot password?
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
