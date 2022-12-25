const mongoose = require('mongoose')

const Schema = mongoose.Schema

const BloodPressure = new Schema({
    sys: {type: Number, required: true, },
    dia: {type: Number, required: true, },
    pulse:{type:Number, require:true},
    userId:{type: mongoose.Schema.Types.ObjectId, ref:"user" },
    date:{type: Date, default: Date.now}
   
})

module.exports = mongoose.model('bloodPressure', BloodPressure)