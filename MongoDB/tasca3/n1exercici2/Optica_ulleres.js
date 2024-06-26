db.createCollection('Client', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'Client',
      required: ['nom', 'adreça', 'data_registre', 'compra'],
      properties: {
        nom: {
          bsonType: 'string'
        },
        adreça: {
          bsonType: 'object',
          title: 'object',
          required: ['carrer', 'ciutat', 'codi_postal'],
          properties: {
            carrer: {
              bsonType: 'string'
            },
            numero: {
              bsonType: 'int'
            },
            pis: {
              bsonType: 'int'
            },
            porta: {
              bsonType: 'string'
            },
            ciutat: {
              bsonType: 'string'
            },
            codi_postal: {
              bsonType: 'int'
            },
            pais: {
              bsonType: 'string'
            }
          }
        },
        telefon: {
          bsonType: 'string'
        },
        email: {
          bsonType: 'string'
        },
        data_registre: {
          bsonType: 'date'
        },
        recomenat_Per: {
          bsonType: 'objectId'
        },
        compra: {
          bsonType: 'array',
          items: {
            title: 'object',
            required: ['ulleres', 'venedor', 'data_compra'],
            properties: {
              ulleres: {
                bsonType: 'object',
                title: 'object',
                required: ['id_ulleres', 'marca', 'proveidor', 'preu', 'muntura', 'vidre'],
                properties: {
                  id_ulleres: {
                    bsonType: 'objectId'
                  },
                  marca: {
                    bsonType: 'string'
                  },
                  proveidor: {
                    bsonType: 'object',
                    title: 'object',
                    required: ['nom', 'telefon', 'fax', 'nif', 'adreça'],
                    properties: {
                      nom: {
                        bsonType: 'string'
                      },
                      telefon: {
                        bsonType: 'string'
                      },
                      fax: {
                        bsonType: 'string'
                      },
                      nif: {
                        bsonType: 'string'
                      },
                      adreça: {
                        bsonType: 'object',
                        title: 'object',
                        required: ['carrer', 'ciutat', 'codi_postal'],
                        properties: {
                          carrer: {
                            bsonType: 'string'
                          },
                          numero: {
                            bsonType: 'int'
                          },
                          pis: {
                            bsonType: 'int'
                          },
                          porta: {
                            bsonType: 'string'
                          },
                          ciutat: {
                            bsonType: 'string'
                          },
                          codi_postal: {
                            bsonType: 'int'
                          },
                          pais: {
                            bsonType: 'string'
                          }
                        }
                      }
                    }
                  },
                  preu: {
                    bsonType: 'double'
                  },
                  muntura: {
                    bsonType: 'object',
                    title: 'object',
                    required: ['tipus', 'color'],
                    properties: {
                      tipus: {
                        enum:
                      },
                      color: {
                        bsonType: 'string'
                      }
                    }
                  },
                  vidre: {
                    bsonType: 'object',
                    title: 'object',
                    required: ['esquerre', 'dret'],
                    properties: {
                      esquerre: {
                        bsonType: 'object',
                        title: 'object',
                        required: ['graduacio', 'color'],
                        properties: {
                          graduacio: {
                            bsonType: 'double'
                          },
                          color: {
                            bsonType: 'string'
                          }
                        }
                      },
                      dret: {
                        bsonType: 'object',
                        title: 'object',
                        required: ['graduacio', 'color'],
                        properties: {
                          graduacio: {
                            bsonType: 'double'
                          },
                          color: {
                            bsonType: 'string'
                          }
                        }
                      }
                    }
                  }
                }
              },
              venedor: {
                bsonType: 'string'
              },
              data_compra: {
                bsonType: 'date'
              }
            }
          }
        }
      }
    }
  }
});

// Generated: 28 / 6 / 2024 | 10: 56: 35 by Moon Modeler - www.datensen.com