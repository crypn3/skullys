// Serves CryptoKitties API and internal Cheshire API
const bodyParser = require('koa-bodyparser')
const cors = require('@koa/cors')
const Koa = require('koa')
const mount = require('koa-mount')
const path = require('path');
const serve = require('koa-static')
const views = require('koa-views')

const routesSkully = require('./routes-skully.js')

module.exports = new Koa()
    .use(cors({ origin: '*' }))
    .use(bodyParser())
    .use(views(path.join(__dirname, '/views'), { extension: 'ejs' }))
    .use(mount('/static', serve('./api/static')))
    .use(routesSkully.routes())
    .use(routesSkully.allowedMethods());
