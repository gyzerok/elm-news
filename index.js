require('babel-register');

var app = require('./src/server').default;

const port = process.env.PORT || 3000;
app.listen(port);
