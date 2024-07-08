const express = require('express');
const { OAuth2Client } = require('google-auth-library');
const app = express();
const client = new OAuth2Client('718073831002-ltarhmstp5b2mr3g146ijjf9v42fojs1.apps.googleusercontent.com');

app.use(express.json());

app.post('/sign-in', async (req, res) => {
  const { idToken, authCode } = req.body;
  
  try {
    const ticket = await client.verifyIdToken({
      idToken: idToken,
      audience: '718073831002-ltarhmstp5b2mr3g146ijjf9v42fojs1.apps.googleusercontent.com', // 클라이언트 ID
    });
    const payload = ticket.getPayload();
    const userId = payload['sub'];
    console.log('User ID: ', userId);

    // 사용자 인증 후 처리 로직 추가
    res.status(200).send('Sign in successful');
  } catch (error) {
    console.error('Error verifying ID token:', error);
    res.status(400).send('Invalid ID token');
  }
});

app.listen(3000, () => {
  console.log('Server started on http://localhost:3000');
});
