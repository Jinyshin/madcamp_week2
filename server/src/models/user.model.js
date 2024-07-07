import mongoose from 'mongoose';

const UserSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  gender: { type: String, required: true },
  birth: { type: Date, required: true },
  addr: { type: String, required: true },
  specAddr: { type: String, required: true },
  phone: { type: String, required: true },
});

const User = mongoose.model('User', UserSchema);

export default User;
