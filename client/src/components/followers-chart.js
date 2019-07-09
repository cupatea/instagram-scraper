import React from 'react'
import { Query } from 'react-apollo'
import { LineChart, Line, XAxis, YAxis, Label, ResponsiveContainer, CartesianGrid, Tooltip } from 'recharts'
import Avatar from '@material-ui/core/Avatar';
import Container from '@material-ui/core/Container'
import Grid from '@material-ui/core/Grid'
import Paper from '@material-ui/core/Paper'
import Typography from '@material-ui/core/Typography'
import { makeStyles } from '@material-ui/core/styles'
import ta from 'time-ago'
import clsx from 'clsx'


import {ObservationsQuery} from '../graphql'

const useStyles = makeStyles(theme => ({
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
    height: 320,
    alignItems: 'flex-end',

  },
  title: {
    flexGrow: 1,
    color: 'black',
    fontSize: '28px',
    fontWeight: '300',
  },
  sidePaper: {
    paddingTop: 30,
    paddingBottom: 24,
    paddingLeft: 16,
    paddingRigh: 16,
    display: 'flex',
    flexDirection: 'row',
  },
  bigAvatar: {
    marginRight: 28,
    width: 77,
    height: 77,
  },
  userContainer: {
    display: 'block',
    width: '100%',
    marginRight: 44,
  },
  userInfo: {
    display: 'flex',
    flexDirection: 'row',
    listStyle: 'none',
    justifyContent: 'space-around',
    borderTop: '1px solid #efefef',
    padding: '12px 0',
  },
  userInfoElement:{
    fontSize: 14,
    textAlign: 'center',
    width: '50%',
    color: '#999'
  },
  userInfoNumber: {
    display: 'block',
    color: '#262626',
    fontWeight: 600,
  },
  select:{
    // borderBottom: '2px solid #F50057',
  }
}))

export default function FollowersChart() {
  const classes = useStyles()

  const fixedHeightPaper = clsx(classes.paper, classes.fixedHeight)
  const prepareData = (data) => (
    data.map(datum => (
      {
        time: ta.ago(datum.scrapeTime),
        followers: datum.count,
      }
    ))
  )
  return (
    <Query query={ObservationsQuery}>
    { ({ data, loading }) => {
      if (loading) return 'loading..'
      return(
        data.observations.map(observation =>(
          <Container maxWidth="lg" className={classes.container} key={observation.id}>
            <Grid container spacing={3}>
              <Grid item xs={12} md={4} lg={4}>
                <Paper className={classes.sidePaper}>
                  <Avatar
                    alt={observation.observee.username}
                    src={observation.observee.profilePicUrl}
                    className={classes.bigAvatar}
                  />
                  <div className={classes.userContainer}>
                    <Typography component="h2" variant="h6" color="inherit" className={classes.title}>
                      {observation.observee.username}
                    </Typography>
                    <ul className={classes.userInfo}>
                      <li className={classes.userInfoElement}>
                        <span>
                          <span className={classes.userInfoNumber}>
                            {observation.observee.postsCount}
                          </span>
                          posts
                        </span>
                      </li>
                      <li className={classes.userInfoElement}>
                        <span>
                          <span className={classes.userInfoNumber}>
                            {observation.observee.followersCount}
                          </span>
                          followers
                        </span>
                      </li>
                    </ul>
                  </div>
                </Paper>
              </Grid>
              <Grid item xs={12} md={8} lg={8}>
                <Paper className={fixedHeightPaper}>
                  <ResponsiveContainer>
                    <LineChart
                      data={prepareData(observation.observee.followersData)}
                      margin={{
                        top: 16,
                        right: 16,
                        bottom: 0,
                        left: 24,
                      }}
                    >
                     <CartesianGrid stroke="#eee" strokeDasharray="5 5"/>
                      <Tooltip />
                      <XAxis dataKey="time" />
                      <YAxis>
                        <Label angle={270} position="left" style={{ textAnchor: 'middle' }}>
                          Followers
                        </Label>
                      </YAxis>
                      <Line type="monotone" dataKey="followers" stroke='#F50057' dot={false} strokeWidth={2} activeDot={{ r: 8 }} />
                    </LineChart>
                  </ResponsiveContainer>
                </Paper>
              </Grid>
            </Grid>
          </Container>
        ))
      )
    }
  }
  </Query>
  )
}
