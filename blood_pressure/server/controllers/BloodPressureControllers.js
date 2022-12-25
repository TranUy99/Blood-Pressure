const BloodPressure = require('../models/BloodPressure')


class BloodPressureController{


    async enterBloodPressure(req,res){
        const { sys, dia, pulse } = req.body
        try {
            const newbloodPressure = new BloodPressure({
                sys,
                dia,
                pulse,
                userId: req.userId
            })
    
            await newbloodPressure.save()
    
            res.json(newbloodPressure )
        } catch (error) {
            console.log(error)
            res.status(500).json({ success: false, message: 'Internal server error' })
        }
    }

    async getBloodPressure(req,res){
        const userId=req.params.userId
        try {
            
            const bloodPressure = await BloodPressure.find({userId} )
            res.json( bloodPressure)
        } catch (e) {
            res.status(500).json({ error: e.message });
        }
    }
}

module.exports = new BloodPressureController()