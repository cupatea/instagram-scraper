import React from 'react';
import ReactDOM from 'react-dom';

import {ApolloClient} from 'apollo-client';
import {InMemoryCache} from 'apollo-cache-inmemory';
import {HttpLink} from 'apollo-link-http';
import {Query, ApolloProvider} from 'react-apollo';
import Login from './pages/login';
import gql from 'graphql-tag';

const cache = new InMemoryCache();
const client = new ApolloClient({
  cache,
  link: new HttpLink({
    uri: 'http://localhost:5000/graphql',
    headers: {
      uid: localStorage.getItem('uid'),
      client: localStorage.getItem('client'),
      'access-token': localStorage.getItem('token'),
      'token-type': 'Bearer',
      'Content-Type': 'application/json',
    },
  }),
});

cache.writeData({
  data: {
    isLoggedIn:
      !!(localStorage.getItem('uid') &&
        localStorage.getItem('client') &&
        localStorage.getItem('token')),
  },
});

const IS_LOGGED_IN = gql`
  query IsUserLoggedIn {
    isLoggedIn @client
  }
`;

ReactDOM.render(
  <ApolloProvider client={client}>
    <Query query={IS_LOGGED_IN}>
      {({data}) => (data.isLoggedIn ? 'You are logged in' : <Login />)}
    </Query>
  </ApolloProvider>,
  document.getElementById('root'),
);
