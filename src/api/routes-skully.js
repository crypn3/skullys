// Routes in this file map to the public CryptoKitties API.
const Router = require('koa-router');
const SkullyData = require("../skully.json");

module.exports = new Router()
  .get('/skullies/:id', async (ctx) => {
    let id = ctx.params.id;

    if (id > "3" || id < "1") {
      ctx.status = 404
    } else {
      ctx.body = SkullyData[id]
    }
  })
  .get('/skullies', async (ctx) => {
    ctx.body = {
      limit: 12,
      offset: 0,
      skullies: SkullyData,
      total: 3,
    }
  })
