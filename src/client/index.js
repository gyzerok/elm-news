var Elm = require('./Main.elm');

var mountNode = document.getElementById('root');
Elm.embed(Elm.Main, mountNode, { swap: false });
