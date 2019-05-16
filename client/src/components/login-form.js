import React, {useState} from 'react'
import {Segment, Button, Form, Message, Container } from 'semantic-ui-react'
import {useSpring, animated} from 'react-spring'

export default function LoginForm({ login, errors }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const onSubmit = event => {
    event.preventDefault()
    login({
      variables: {
        email,
        password
      }
    })
  }
  const fade = useSpring({ opacity: errors.length > 0 ? 1 : 0 })

  return (
    <Container style={{ paddingTop: '20px'}}>
      <Segment>
        <animated.div style={fade}>
          <Message>
            <Message.Header>Action Forbidden</Message.Header>
            <Message.List>
            {
              errors.map(error =>
                 <Message.Item key={error}>
                  {error}
                 </Message.Item>
              )
            }
            </Message.List>
          </Message>
        </animated.div>
        <Form
          onSubmit = { event => onSubmit(event) }>
          <Form.Field style= { { paddingTop: '20px'} }>
            <label>Email</label>
            <input
              type = 'email'
              autoComplete = 'email'
              onChange = { (event) => setEmail(event.target.value) }
            />
          </Form.Field>
          <Form.Field>
            <label>Password</label>
            <input
              type = 'password'
              autoComplete = 'current-password'
              onChange = { (event) => setPassword(event.target.value) }
            />
          </Form.Field>

          <Button type='submit'>Submit</Button>
        </Form>
      </Segment>
    </Container>
  )
}
