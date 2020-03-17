const express = require('express');
const bodyParser = require('body-parser');
const product = require('./routes/product.route'); // Imports routes for the products
const app = express();
const service = require('./services/user.services');
app.set('view engine', 'ejs');
const productSchema = require('./models/product.model')
const path = require('path');
const ejs = require('ejs')
    // Set up mongoose connection

const mongoose = require('mongoose');
let dev_db_url = 'mongodb://localhost:27017/productstutorial';
let mongoDB = process.env.MONGODB_URI || dev_db_url;
app.use('/products', product);
app.use(bodyParser.json());
app.use(bodyParser.raw());
app.use(bodyParser.urlencoded({ extended: false }));
//app.set('views', path.join(__dirname, 'CRUDNODEMONGO', 'views'));

mongoose.connect(mongoDB, {
    useUnifiedTopology: true,
    useNewUrlParser: true,
});
mongoose.Promise = global.Promise;
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));

app.get('/', (req, res) => {
    res.redirect('/login')
})
var login = "login"
app.get('/login', function(req, res) {
    res.render('login', { title: 'Login Form' });
});

// app.post('/login', function(req, res) {
//     console.log("login started from here");

// })
app.get('/register', function(req, res) {
    res.render('register', { title: 'Register Form' });
});
// app.post('/register', (req, res) => {
//     console.log("registration started");

// })
let port = 1234;
app.listen(port, () => {
    console.log('Server is up and running on port number ' + port);
});
const products = [{
    name: 'samsung',
    price: 400
}, {
    name: 'samsung',
    price: 400
}];
var prod = [{
    name: 'samsung',
    price: 400
}, {
    name: 'samsung',
    price: 400
}];

app.get('/productPage', (req, res) => {
    res.render('product', {
        products: prod //getDataProducts()
    });
});

function getDataProducts() {

    const Product = db.model('Product', productSchema.productSchema);
    console.log("starting take from here :")
    const docs = db.useDb('producttutorial').collection('products').find({});
    console.log(docs);
    return docs;
    //const docs = Product.find(product, function(err, prod) {
    //  if (err) throw err; //console.log("errors :", err);
    //res.json(prod);
    //});
    //console.log((docs));
    //return docs;
}

getDataProducts();