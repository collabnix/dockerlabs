const log = require( 'ronin-logger' )
let handler = require( './handlers' )
const inMemoryHandler = require( './handlers/inmemory' )
const database = require( 'ronin-database' )

function useServer( router, rbac, inmemory ) {

  let db = null

  if( inmemory ) {
    handler = inMemoryHandler
  } else {
    db = database.getConnection()
    if( !db ) {
      throw new Error( 'Ronin database connection required. Please create a ronin-database connection before using the ronin-mocks server.' ).stack
    }
  }

  if( rbac ) {
    router.get(  		`/:entity`, 			rbac.can.read(),    handler.entitySearch )
    router.post( 		`/:entity`, 			rbac.can.create(),  handler.entityCreate )
    router.get(  		`/:entity/:id`, 	rbac.can.read(),    handler.entityById )
    router.put(  		`/:entity/:id`, 	rbac.can.update(),  handler.entityUpdate )
    router.delete(  `/:entity/:id`, 	rbac.can.delete(),  handler.entityDelete )
  } else {
    router.get(  		`/:entity`, 			handler.entitySearch )
    router.post( 		`/:entity`, 			handler.entityCreate )
    router.get(  		`/:entity/:id`, 	handler.entityById )
    router.put(  		`/:entity/:id`, 	handler.entityUpdate )
    router.delete(  `/:entity/:id`, 	handler.entityDelete )
  }

  return router
}

module.exports = {
  server: useServer
}