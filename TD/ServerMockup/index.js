var express = require("express");
var app = express();
app.get("/account", (req, res, next) => {
 res.json({"user":"magiccrab", "perms":["ride","drive"]});
});
app.listen(3069, () => {
 console.log("Server running on port 3000");
});
