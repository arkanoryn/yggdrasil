'use strict';

require('./index.html');
var Elm = require('./Main');

var app = Elm.Main.embed(document.getElementById('elmApp'),
                         {
                           user: "Tom",
                           token: "123"
                         }
                        );

window.app = app;

app.ports.save.subscribe( function(datas) {
  localStorage.setItem("credentials", JSON.stringify(datas));
  console.log("user is: " + datas);
} );

window.setTimeout(function(){
  var credentials = localStorage.getItem("credentials");
  app.ports.retrieve.send(JSON.parse(credentials));
}, 0);
