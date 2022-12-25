const mongoose = require('mongoose')

const Schema = mongoose.Schema

const User = new Schema({
    username: {type: String, required: true, },
    email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
    password:{type:String, require:true},
    address:{type: String, },
    phonenumber: {type: String,},
    gender:{type:String,},
    image: {type: String},
    birthday:{type:String},
})

module.exports = mongoose.model('user', User)