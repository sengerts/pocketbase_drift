migrate((db) => {
  const collection = new Collection({
    "id": "u21lspvbnqr76ll",
    "created": "2023-01-08 14:33:41.740Z",
    "updated": "2023-01-08 14:33:41.740Z",
    "name": "todo",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "hi1m2zrs",
        "name": "name",
        "type": "text",
        "required": true,
        "unique": false,
        "options": {
          "min": 1,
          "max": null,
          "pattern": ""
        }
      }
    ],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("u21lspvbnqr76ll");

  return dao.deleteCollection(collection);
})
