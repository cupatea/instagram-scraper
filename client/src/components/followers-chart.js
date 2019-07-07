import React from 'react'
import { Query } from 'react-apollo'
import { LineChart, Line, XAxis, YAxis, Label, ResponsiveContainer, CartesianGrid, Tooltip } from 'recharts'
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
    height: 240,
  },
  title: {
    flexGrow: 1,
    color: 'black',
    fontSize: '16px',
    fontWeight: '400',
    textTransform: 'uppercase',
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
              <Grid item xs={12} md={8} lg={9}>
                <Paper className={fixedHeightPaper}>
                  <Typography component="h2" variant="h6" color="inherit" gutterBottom className={classes.title}>
                    {observation.observee.username}
                  </Typography>
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
