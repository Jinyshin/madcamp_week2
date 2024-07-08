import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

mongoose
  .connect(process.env.DB_URI)
  .then(() => {
    console.log('Successfully connected to the database');
  })
  .catch((error) => {
    console.error('Error connecting to the database', error);
  });

export default mongoose;
