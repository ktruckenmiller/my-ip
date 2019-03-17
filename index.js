'use strict';

const Hapi = require('hapi');

const server = Hapi.server({
    port: 3000,
    host: '0.0.0.0'
});

server.route({
    method: 'GET',
    path: '/',
    handler: (request, h) => {
      try {
        console.log(request.headers.xForwardedFor)
        return request.headers.xForwardedFor;
      }catch(e) {
        return request.info.remoteAddress;
      }

    }
});

const init = async () => {

    await server.start();
    console.log(`Server running at: ${server.info.uri}`);
};

process.on('unhandledRejection', (err) => {

    console.log(err);
    process.exit(1);
});

// listen on SIGINT signal and gracefully stop the server
process.on('SIGINT', function () {
  console.log('stopping hapi server')

  server.stop({ timeout: 10000 }).then(function (err) {
    console.log('hapi server stopped')
    process.exit((err) ? 1 : 0)
  })
})

init();
