import React from 'react'
import ReactDOM from 'react-dom'
import { Line } from 'react-chartjs-2'
import ta from 'time-ago'
import newGetRequest from '../../actions/newGetRequest'


document.addEventListener('DOMContentLoaded', async () => {
  const userType = document.querySelector('#chart-container').dataset.type

  const dataEndpointUrl = userType === 'admin'
    ? 'api/v1/admins/followers_data'
    : ''

  const { users, chartData } = await newGetRequest(dataEndpointUrl)

  const preparedData = {
    labels: chartData.filter(datum => datum.instagramUserId === users[0].id)
      .map(datum => ta.ago(datum.scrapeTime)),
    datasets: users.map(user => ({
      label: user.username,
      fill: false,
      lineTension: 0.1,
      backgroundColor: 'rgba(75,192,192,0.4)',
      borderColor: 'rgba(75,192,192,1)',
      borderCapStyle: 'butt',
      borderDash: [],
      borderDashOffset: 0.0,
      borderJoinStyle: 'miter',
      pointBorderColor: 'rgba(75,192,192,1)',
      pointBackgroundColor: '#fff',
      pointBorderWidth: 1,
      pointHoverRadius: 5,
      pointHoverBackgroundColor: 'rgba(75,192,192,1)',
      pointHoverBorderColor: 'rgba(220,220,220,1)',
      pointHoverBorderWidth: 2,
      pointRadius: 1,
      pointHitRadius: 10,
      data: chartData.filter(datum => datum.instagramUserId === user.id).map(datum => datum.count),
    })),
  }
  const container = document.querySelector('#chart-line')
  const component = <Line data = { preparedData } />
  ReactDOM.render(component, container)
})
