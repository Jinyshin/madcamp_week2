

import { MongoClient } from 'mongodb';

const url = process.env.MONGO_URI;

const createTodo = async (req, res, next) => {
  const newTodo = {
    id: req.body.id,
    nickname: req.body.nickname,
  };

  const client = new MongoClient(url);

  try {
    await client.connect();
    const database = client.db('GameCluster');
    const collection = database.collection('todos');
    const result = await collection.insertOne(newTodo);
    res.status(201).json(result);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to create todo' });
  } finally {
    await client.close();
  }
};

const getTodos = async (req, res, next) => {
  const client = new MongoClient(url);

  try {
    await client.connect();
    const database = client.db('GameCluster');
    const collection = database.collection('todos');
    const todos = await collection.find({}).toArray();
    res.status(200).json(todos);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to fetch todos' });
  } finally {
    await client.close();
  }
};

export { createTodo, getTodos };
