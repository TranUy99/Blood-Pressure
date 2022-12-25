const Booking =require('../models/Booking');

class BookingController{
    async enterBooking(req,res){
        const { timeType, date, doctorId,isAvailable } = req.body
        try {
            const newBooking  = new Booking({
                timeType,
                date,
                isAvailable,
                userId: req.userId,
                doctorId,
            })
    
            await newBooking.save()
    
            res.json(newBooking )
        } catch (error) {
            console.log(error)
            res.status(500).json({ success: false, message: 'Internal server error' })
        }
    }
}
module.exports = new BookingController()