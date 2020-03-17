const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let UserSchema = new Schema({
    //  id: { type: String },
    name: { type: String, required: true, max: 100 },
    email: { type: String, required: true, max: 100 },
    password: { type: Number, required: true },
});


// Export the model
module.exports = mongoose.model('User', UserSchema);