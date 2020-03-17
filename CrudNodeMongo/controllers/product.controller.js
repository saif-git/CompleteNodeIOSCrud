const Product = require('../models/product.model');

//Simple version, without validation or sanitation
exports.test = function(req, res) {
    res.send('Greetings from the Test controller!');
};


exports.product_create = function(req, res, next) {
    //console.log("product", product)
    let product = new Product({
        name: req.body.name,
        price: req.body.price
    });
    console.log('Name: ' + req.body.name);
    console.log('Price: ' + req.body.price);
    product.save(function(err) {
        if (err) {
            console.log("product", req.body)

            return next(err);
        }
        res.send('Product Created successfully')
    })
};


// controllers/products.controller.js
exports.product_details = function(req, res) {
    Product.findById(function(err, product) {
        if (err) return next(err);
        res.send(product);
    })
};

exports.product_All = function(req, res) {
    Product.find(function(err, product) {
        if (err) return next(err);
        res.send(product);
    })
};

// controllers/products.controller.js

exports.product_update = function(req, res, next) {
    Product.findByIdAndUpdate(req.params.id, { $set: req.body }, function(err, product) {
        if (err) return next(err);
        res.send('Product udpated.');
    });
};

// controllers/products.controller.js
exports.product_delete = function(req, res) {
    Product.findByIdAndRemove(req.params.id, function(err) {
        if (err) return next(err);
        res.send('Deleted successfully!');
    })
};

exports.login = (req, res) => {
    res.sendFile(path.join(__dirname + '../views/login.html'))
};


exports.register = (req, res) => {
    res.sendFile(path.join(__dirname + '../views/register.ejs'))
};


exports.product_page = (req, res) => {
    res.render('../views/product.ejs');
}