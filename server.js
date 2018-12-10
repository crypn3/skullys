const Api = require('./src/api');
const { log } = console;

const Server = {

    async startApiServer() {
        log('> Starting local CryptoKitties API server...');

        Api.listen("4000")
    },


    async start() {
        await this.startApiServer();
        log('');
        log('Cheshire is live 😺  Here\'s what\'s inside:');
        log('Server start port 4000');
    },
}

Server.start()
