import mongoose from 'mongoose';

const UserSchema = new mongoose.Schema({
  displayName: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  id: { type: String, required: true },
  photoUrl: { type: String, required: true },
});

const User = mongoose.model('User', UserSchema);

export default User;
