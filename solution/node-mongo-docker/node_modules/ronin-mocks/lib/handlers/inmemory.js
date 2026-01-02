const moment 		= require( 'moment' )
const errors = require( 'ronin-errors' )
const pluralize = require( 'pluralize' )
const log 			= require( 'ronin-logger' )
const { v4: uuidv4 } = require( 'uuid' )

module.exports = {
	setEntity, 
	
	entitySearch,
	entityCreate,
	entityById,
	entityUpdate,
	entityDelete
}

let datastore = {}

function setEntity( entity, req, res, next ) {
	req.params.entity = entity
	next()
}

function getCollectionName( req ) {
	let collection = req.params.entity
	if( collection ) {
		collection = pluralize.plural( collection )	
	}

	return collection
}

function getDataStore( collection ) {
  if( !datastore[ collection ] ) {
    datastore[ collection ] = []
  }

  return datastore[ collection ]
}

async function entitySearch( req, res, next ) {
	const collection = getCollectionName( req )
	if( !collection ) {
		return next( roninErrors.http.MissingParameterError( `Missing entity name` ) )
	}

  let store =  getDataStore( collection )

	return res.json({ code: 'success', meta: { total: store.length, count: store.length }, payload: store })
}

function entityCreate( req, res, next ) {
	const collection = getCollectionName( req )
	if( !collection ) {
		return next( new errors.MissingParameterError( `Missing entity name` ) )
	}

	let entity = req.body
	if( !entity ) {
		return next( new errors.MissingParameterError( `Missing entity object` ) )
	}

	if( !Array.isArray( entity) ) {
		entity = [entity]
	}

	entity.forEach( e => {
		if( !e.id ) {
			e.id = uuidv4()
		}
		e.createDate = moment().toDate()
	})

  let store =  getDataStore( collection )
  store.push( ...entity )

  return res.json({ code: 'success', payload: store })
}

function entityById( req, res, next ) {
	const collection = getCollectionName( req )
	if( !collection ) {
		return next( new errors.MissingParameterError( `Missing entity name` ) )
	}

	const id = req.params.id
	if( !id ) {
		return next( new errors.MissingParameterError( `Missing entity id` ) )
	}

	const store = getDataStore( collection )
  
	let results = store.find( item => item.id == req.params.id )
	results = results || {}

	return res.json({ code: 'success', payload: results })
}

async function entityUpdate( req, res, next ) {
	const collection = getCollectionName( req )
	if( !collection ) {
		return next( new errors.MissingParameterError( `Missing entity name` ) )
	}

	const id = req.params.id
	if( !id ) {
		return next( new errors.MissingParameterError( `Missing entity id` ) )
	}

	const update = req.body
	if( !update ) {
		return next( new errors.MissingParameterError( `Missing entity object` ) )
	}

  const store = getDataStore( collection )
  for( let i = 0; i < store.length; i++ ) {
    let item = store[i]
    if( item.id == id ) {
      store[i] = update
      store[i].id = id
    }
  }

  return res.json({ code: 'success', payload: store })
}

function entityDelete( req, res, next ) {
	const collection = getCollectionName( req )
	if( !collection ) {
		return next( new errors.MissingParameterError( `Missing entity name` ) )
	}

	const id = req.params.id
	if( !id ) {
		return next( new errors.MissingParameterError( `Missing entity id` ) )
	}

	const store = getDataStore( collection )
  for( let i = 0; i < store.length; i++ ) {
    let item = store[i]
    if( item.id === id ) {
      store.splice( i, 1 )
    }
  }
  
  return res.json({ code: 'success', payload: store })
	
}