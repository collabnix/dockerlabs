const log = require( 'ronin-logger' )
const mongo = require( 'mongodb' ).MongoClient

let connections = {}

async function connect( url, name = 'default' ) {
	if( !url ) {
		throw new Error( 'Connection String Required. Please provide a mongodb connection string. See https://docs.mongodb.com/manual/reference/connection-string/ for more details.' ).stack
	}
	
	if ( connections[name] ) resolve( connections[name] )

	try {
		const db = await mongo.connect( url, { useNewUrlParser: true, useUnifiedTopology: true } )
		connections[name] = db.db()
		return db
	} catch( err ) {
		throw new Error( `Error connecting to mongo. ${err.message}` ).stack
	}
	
}

async function getConnection( name = 'default' ) {
	let connection = connections[ name ]
	if( !connection ) {
		connection = await connect( 'mongodb://localhost:27017/ronin' )
	}

	return connection
}

module.exports = {
	connect,
	getConnection
}