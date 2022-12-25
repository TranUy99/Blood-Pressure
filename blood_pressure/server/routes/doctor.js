
const router = require("express").Router()  
const DoctorController =require('../controllers/DoctorControllers')
const verifyToken = require('../middleware/auth')


router.post("/api/doctor/register",DoctorController.registerDoctor)
router.post("/api/doctor/login",DoctorController.loginDoctor)
router.post("/doctor/tokenIsValid", DoctorController.tokenIsValid)
//   doctorRouter.get("/api/doctor", doctorToken, async (req, res) => {
// 	const doctor = await Doctor.findById(req.doctor);
// 	res.json({ ...doctor._doc, token: req.token });
//   });  
router.get('/api/getDoctor',verifyToken,DoctorController.getDoctor )


module.exports = router;