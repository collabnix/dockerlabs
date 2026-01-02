const moment 		= require( 'moment' )
const errors = require( 'ronin-errors' )
const pluralize = require( 'pluralize' )
const log 			= require( 'ronin-logger' )

const Entity = require( 'ronin-entity' )

module.exports = {
	setEntity, 
	
	entitySearch,
	entityAggregate,
	entityCreate,
	entityById,
	entityUpdate,
	entityDelete
}

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

async function entitySearch( req, res, next ) {
	const collection = getCollectionName( req )
	if( !collection ) {
		return next( roninErrors.http.MissingParameterError( `Missing entity name` ) )
	}

	const query		=	req.query.query 	? JSON.parse( req.query.query ) 	: {}
	const sort 		=	req.query.sort 	 	? JSON.parse( req.query.sort ) 		: {}
	const project = req.query.project ? JSON.parse( req.query.project ) : {}

	const limit = req.query.limit ? parseInt( req.query.limit ) : null
	const skip  = req.query.skip  ? parseInt( req.query.skip )  : 0

	for ( let key in query ) {
		let value = query[ key ]

		let lastTwoOfKeyString = key.slice( key.length - 2 )
		let lastFourOfKeyString = key.slice( key.length - 4 )
		let firstFourofKeyString = key.slice( 0, 4 )

		if ( lastTwoOfKeyString.toUpperCase() === "ID" ) {
			query[ key ] = Entity.ObjectID( value )
		}

		if ( firstFourofKeyString.toUpperCase() === "DATE" || lastFourOfKeyString.toUpperCase() === "DATE" ) {
			if ( value.$lte ) {
				value.$lte = moment( value.$lte ).toDate()
			}
			if ( value.$gte ) {
				value.$gte = moment( value.$gte ).toDate()
			}
		}
	}
	log.debug( `collection: ${collection}`)
	log.debug( `query` )
	log.debug( query )

	const store = new Entity( collection )
	const total = await store.count( query )
	const results = await store.find( query, {sort, project, limit, skip} )

	return res.json({ code: 'success', meta: { total: total, count: results.length }, payload: results })
}

function entityAggregate( req, res, next ) {
	const collection = getCollectionName( req )
	if( !collection ) {
		return next( new errors.MissingParameterError( `Missing entity name` ) )
	}

	const query		=	req.query.query 	? JSON.parse( req.query.query ) 	: {}

	const store = new Entity( collection )
	return store
		.aggregate( query )
		.then( results => {
			return res.json({ code: 'success', meta: { total: total, count: results.length }, payload: results })
		})
		.catch( reason => {
			return res.json({ code: 'error', payload: reason })
		})
}

function entityCreate( req, res, next ) {
	const collection = getCollectionName( req )
	if( !collection ) {
		return next( new errors.MissingParameterError( `Missing entity name` ) )
	}

	const entity = req.body
	if( !entity ) {
		return next( new errors.MissingParameterError( `Missing entity object` ) )
	}

	entity.createDate = moment().toDate()

	const store = new Entity( collection )
	return store
		.insert( entity )
		.then( results => {
			return store.getById( results.insertedId ).then( results => res.json({ code: 'success', payload: results }) )
		})
		.catch( reason => {
			return res.json({ code: 'error', payload: reason })
		})

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

	const store = new Entity( collection )
	return store
		.getById( id )
		.then( results => {
			return res.json({ code: 'success', payload: results })
		})
		.catch( reason => {
			return res.json({ code: 'error', payload: reason })
		})

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

	const withModifiers = req.params.withModifiers || req.query.withModifiers

	const store = new Entity( collection )

	try {
		const results = await store.updateById( id, update, withModifiers )
		if( results ) {
			return store.getById( id ).then( results => res.json({ code: 'success', payload: results }) )
		}
	} catch( reason ) {
		return res.json({ code: 'error', payload: reason })
	}
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

	const store = new Entity( collection )
	return store
		.deleteById( id )
		.then( results => {
			return res.json({ code: 'success', payload: results })
		})
		.catch( reason => {
			return res.json({ code: 'error', payload: reason })
		})
}