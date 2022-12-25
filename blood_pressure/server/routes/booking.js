const router = require("express").Router()
const verifyToken = require('../middleware/auth')
const BookingController =require('../controllers/Booking')

//POST BLOOD PRESSURE
router.post('/api/booking/enterBooking',verifyToken,BookingController.enterBooking )



module.exports = router;