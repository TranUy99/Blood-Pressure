const mongoose = require('mongoose')

const Schema = mongoose.Schema

const Booking = new Schema({
    userId: {type: mongoose.Schema.Types.ObjectId, ref:"user" } ,
   doctorId:{type:String } ,
   timeType: {type:String } ,
   date : {type:String } ,
   isAvailable: {type: Boolean,}
})

module.exports = mongoose.model('booking', Booking)