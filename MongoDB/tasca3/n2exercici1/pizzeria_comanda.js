db.createCollection('Comanda', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'Comanda',
      required: ['pizzeria', 'producte', 'preu', 'client', 'entregada', 'pagada', 'data'],
      properties: {
        pizzeria: {
          bsonType: 'object',
          title: 'object',
          required: ['nom', 'adreça', 'localitat', 'provincia', 'codi_postal'],
          properties: {
            nom: {
              bsonType: 'string'
            },
            adreça: {
              bsonType: 'string'
            },
            localitat: {
              bsonType: 'string'
            },
            provincia: {
              bsonType: 'string'
            },
            codi_postal: {
              bsonType: 'int'
            }
          }
        },
        producte: {
          bsonType: 'array',
          items: {
            title: 'object',
            required: ['id_producte', 'nom', 'preu'],
            properties: {
              id_producte: {
                bsonType: 'objectId'
              },
              nom: {
                bsonType: 'string'
              },
              preu: {
                bsonType: 'double'
              },
              tipus: {
                enum: pizza
                hamburguesa
                beguda
              },
              descripcio: {
                bsonType: 'string'
              },
              imatge: {
                bsonType: 'string'
              }
            }
          }
        },
        preu: {
          bsonType: 'double'
        },
        client: {
          bsonType: 'object',
          title: 'object',
          required: ['client_id', 'nom', 'cognom', 'telefon'],
          properties: {
            client_id: {
              bsonType: 'objectId'
            },
            nom: {
              bsonType: 'string'
            },
            cognom: {
              bsonType: 'string'
            },
            telefon: {
              bsonType: 'string'
            }
          }
        },
        entregada: {
          bsonType: 'bool'
        },
        pagada: {
          bsonType: 'bool'
        },
        data: {
          bsonType: 'date'
        },
        repartiment_domicili: {
          bsonType: 'object',
          title: 'object',
          required: ['adreça', 'telefon', 'repartidor', 'hora_entrega'],
          properties: {
            adreça: {
              bsonType: 'object',
              title: 'object',
              required: ['carrer', 'numero', 'localitat', 'codi_postal'],
              properties: {
                carrer: {
                  bsonType: 'string'
                },
                numero: {
                  bsonType: 'int'
                },
                porta: {
                  bsonType: 'string'
                },
                localitat: {
                  bsonType: 'string'
                },
                codi_postal: {
                  bsonType: 'int'
                }
              }
            },
            telefon: {
              bsonType: 'string'
            },
            nota: {
              bsonType: 'string'
            },
            repartidor: {
              bsonType: 'string'
            },
            hora_entrega: {
              bsonType: 'date'
            }
          }
        }
      }
    }
  }
});