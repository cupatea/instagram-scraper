import React from 'react';
import ReactDOM from 'react-dom';

import {ApolloClient} from 'apollo-client';
import {InMemoryCache} from 'apollo-cache-inmemory';
import {HttpLink} from 'apollo-link-http';
import {ApolloProvider} from 'react-apollo';

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
    },
  }),
});

ReactDOM.render(
  <ApolloProvider client={client}>
    Hello from Apolo React client
  </ApolloProvider>,
  document.getElementById('root'),
);
