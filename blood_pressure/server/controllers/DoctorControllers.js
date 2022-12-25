const Doctor = require('../models/Doctor')
const bcryptjs = require("bcryptjs");
const jwt = require('jsonwebtoken')

class DoctorController{
    async registerDoctor(req,res){
        const { doctorName, email,password ,address,phonenumber,gender} = req.body

        // Simple validation
        if (!doctorName || !password||!email)
            return res
                .status(400)
                .json({ success: false, message: 'Missing username and/or password' })
    
                try {
                    const { doctorName, email, password } = req.body;
                
                    const existedDoctor = await Doctor.findOne({ email });
                    if (existedDoctor) {
                      return res
                        .status(400)
                        .json({ msg: "User with same email already exists!" });
                    }
                
                    const hashedPassword = await bcryptjs.hash(password, 8);
                
                    let doctor = new Doctor({
                      email,
                      password: hashedPassword,
                      doctorName,
                      address,
                      phonenumber,
                      gender,
                      
                    });
                    doctor = await doctor.save();
                    res.json(doctor);
                  } catch (e) {
                    res.status(500).json({ error: e.message });
                  }
    }


    async loginDoctor(req,res){
      const { email, password } = req.body

// Simple validation
if (!email || !password)
  return res
    .status(400)
    .json({ success: false, message: 'Missing uame and/or password' })

try {
  // Check for existing user
  const doctor = await Doctor.findOne({ email })
  if (!doctor)
    return res
      .status(400)
      .json({ success: false, message: 'User with same email already exists!' })

  // Username found
  const passwordValid = await bcryptjs.compare(password, doctor.password);
  if (!passwordValid)
    return res
      .status(400)
      .json({ success: false, message: 'Incorrect username or password' })

  // All good
  // Return token
  const token = jwt.sign(
    { doctorId: doctor._id },
    process.env.ACCESS_TOKEN_SECRET
  )

  res.json({
    success: true,
    message: 'User logged in successfully',
    token
  })
} catch (error) {
  console.log(error)
  res.status(500).json({ success: false, message: 'Internal server error' })
}
  }

    async tokenIsValid(req,res){
        try {
            const token = req.header("Authorization");
            if (!token) return res.json(false);
            const verified = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
            if (!verified) return res.json(false);
        
            const doctor = await Doctor.findById(verified.id);
            if (!doctor) return res.json(false);
            res.json(true);
          } catch (e) {
            res.status(500).json({ error: e.message });
          }
    }

    async getDoctor(req,res){
        try {
            const doctor = await Doctor.find({ })
            res.json( doctor)
        } catch (e) {
            res.status(500).json({ error: e.message });
        }
    }
}
module.exports = new DoctorController()