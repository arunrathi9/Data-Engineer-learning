import pymongo

client = pymongo.MongoClient('mongodb://127.0.0.1:27017/neurolabDB')

db = client['neurolabDB']

#print(client.list_database_names())

collection = db['Mongo_demo']

my_row = {'Name': 'Arun Rathi', 'Current':'Active'}

col = collection.insert_one(my_row)

print(col.inserted_id)

def databaseName(client):
    names = client.list_database_names()
    return names

print(databaseName(client))