import React, {useState} from 'react'
import clsx from 'clsx'
import { makeStyles } from '@material-ui/core/styles'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import Typography from '@material-ui/core/Typography'
import IconButton from '@material-ui/core/IconButton'
import Menu from '@material-ui/core/Menu'
import MenuItem from '@material-ui/core/MenuItem'
import AccountCircle from '@material-ui/icons/AccountCircle'
import ShowChart from '@material-ui/icons/ShowChart'

const drawerWidth = 240

const useStyles = makeStyles(theme => ({
  toolbar: {
    paddingRight: 24, // keep right padding when drawer closed
  },
  toolbarIcon: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'flex-end',
    padding: '0 8px',
    ...theme.mixins.toolbar,
  },
  appBar: {
    zIndex: theme.zIndex.drawer,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    backgroundColor: '#212225'
  },
  title: {
    flexGrow: 1,
    fontSize: '16px',
    fontWeight: '400',
    lineHeight: '24px',
    textTransform: 'uppercase',
    marginLeft: '10px'

  },
  drawerPaper: {
    position: 'relative',
    whiteSpace: 'nowrap',
    width: drawerWidth,
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  drawerPaperClose: {
    overflowX: 'hidden',
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    width: theme.spacing(7),
    [theme.breakpoints.up('sm')]: {
      width: theme.spacing(9),
    },
  },
  appBarSpacer: theme.mixins.toolbar,
  content: {
    flexGrow: 1,
    height: '100vh',
    overflow: 'auto',
  },
  container: {
    paddingTop: theme.spacing(4),
    paddingBottom: theme.spacing(4),
  },
  paper: {
    padding: theme.spacing(2),
    display: 'flex',
    overflow: 'auto',
    flexDirection: 'column',
  },
  fixedHeight: {
    height: 240,
  },
}))

export default function Dashboard({logoutFunction, children}) {
  const classes = useStyles()
  const [profileMenuAnchorEl, setProfileMenuAnchorEl] = useState(null)


  return (
    <React.Fragment>
      <AppBar position="absolute" className={clsx(classes.appBar)}>
        <Toolbar className={classes.toolbar}>
          <ShowChart />
          <Typography component="h1" variant="h6" color="inherit" noWrap className={classes.title}>
            Instat
          </Typography>
          <IconButton
             aria-haspopup="true"
             onClick={event => setProfileMenuAnchorEl(event.currentTarget) }
             color="inherit"
           >
             <AccountCircle />
           </IconButton>
        </Toolbar>
      </AppBar>
      <Menu
        anchorEl={profileMenuAnchorEl}
        anchorOrigin={{ vertical: 'top', horizontal: 'right' }}
        transformOrigin={{ vertical: 'top', horizontal: 'right' }}
        open={Boolean(profileMenuAnchorEl)}
        onClose={() => setProfileMenuAnchorEl(null)}
      >
        <MenuItem onClick={() => logoutFunction()}>Logout</MenuItem>
      </Menu>
      <main className={classes.content}>
        <div className={classes.appBarSpacer} />
        { children }
      </main>
    </React.Fragment>
  )
}
