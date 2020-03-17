const User = require('../models/user.model');

exports.login = function(req, res, next) {

    //console.log("product", product)

    let User = new User({
        email: req.body.email,
        username: req.body.username,
        password: req.body.password,
    });

    User.save(function(err) {
        if (err) {
            console.log("User", req.body);

            return next(err);
        }
        res.send('User Created successfully');
    })
};