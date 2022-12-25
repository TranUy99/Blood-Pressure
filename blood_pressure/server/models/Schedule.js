const mongoose = require('mongoose')

const Schema = mongoose.Schema

const Schedule = new Schema({
    timeType: {type: String },
    date :{type:String} , 
    isAvailable: {type: Boolean,ref:"booking" },
    doctorId :{type: mongoose.Schema.Types.ObjectId, ref:"doctor" }, 
   
})

module.exports = mongoose.model('schedule', Schedule)