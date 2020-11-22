module.exports = {
  auth: {
    client: {
      accounts: [{ id: 1, username: 'user1', password: '123456' }],
    },
    jwt: {
      privateKey: 'tms-koa-secret',
      expiresIn: 3600,
    },
  },
  cors: {
    credentials: true,
  },
}
