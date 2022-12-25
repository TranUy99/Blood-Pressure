const router = require("express").Router()
const doctorToken = require('../middleware/doctor')
const ScheduleController =require('../controllers/ScheduleController')
const verifyToken =require('../middleware/auth')

router.post('/api/schedule/enterSchedule',doctorToken,ScheduleController.enterSchedule )
router.post('/api/schedule/getSchedule/:doctorId',verifyToken,ScheduleController.getSchedule )

router.patch('/api/schedule/updateSchedule',verifyToken,ScheduleController.updateSchedule )
module.exports = router;