const router = require("express").Router()
const verifyToken = require('../middleware/auth')
const BloodPressureController =require('../controllers/BloodPressureControllers')

//POST BLOOD PRESSURE
router.post('/api/bloodPressure/enterBloodPressure',verifyToken,BloodPressureController.enterBloodPressure )

router.get('/api/bloodPressure/getBloodPressure/:userId',verifyToken, BloodPressureController.getBloodPressure)

module.exports = router;