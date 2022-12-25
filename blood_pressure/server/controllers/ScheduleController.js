const Schedule =require('../models/Schedule');

class ScheduleController{
    async enterSchedule(req,res){
       
           
            try {
                const doctorId  = req.body.doctorId;

                const {timeType,date,isAvailable}=req.body
                const Check1 =await Schedule.findOne({
                  doctorId,timeType,date
                })
                if (Check1)return res
                    .status(400)
                    .json({ success: false, message: 'false' })
                else{    
                const newSchedule = new Schedule({
                    timeType,
                    date,
                    isAvailable,
                    doctorId: req.doctorId
                    
                })
                await newSchedule.save()
                res.json(newSchedule )
            }            
            } catch (error) {
                console.log(error)
                res.status(500).json({ success: false, message: 'Internal server error' })
            }
    }

    async getSchedule(req,res){
       
        try {
    
            const doctorId=req.params.doctorId
            const schedule = await Schedule.find({ doctorId,date: req.body.date,isAvailable:{$not:{$eq:false}} })

            return res.json( schedule)
            
            
        
        } catch (error) {
            res.status(500).json({ error: e.message });
        }
    }
 async updateSchedule(req,res){
    try {
    
        const schedule = await Schedule.findOneAndUpdate(req.body,{isAvailable:"false"} )

        return res.json( schedule)
    } catch (error) {
        res.status(500).json({ error: e.message });
    }
 }

}
module.exports = new ScheduleController()