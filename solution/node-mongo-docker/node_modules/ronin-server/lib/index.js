const http					= require( 'http' )
const express 			= require( 'express' )
const stoppable			= require( 'stoppable' )
const fileUpload 		= require( 'express-fileupload' )
const cors 					= require( 'cors' )
const cookieParser	= require( 'cookie-parser' )
const bodyParser 		= require( 'body-parser' )

const log 					= require( 'ronin-logger' )

function server( config = {} ) {
	const app = express()
	const port = normalizePort( config.port || '8000' )

	app.set( 'port', port )

	app.use( cors() )
	app.use( fileUpload() )

	app.use( (req, res, next ) => {
		log.info( `${req.method} ${req.url}` )
		next()
	})

	app.use( bodyParser.json() )
	app.use( bodyParser.urlencoded({ extended: false }) )
	app.use( cookieParser() )

	//
	//	S T A R T   T H E   S E R V E R
	//
	app.start = () => {
		return new Promise( (resolve, reject) => {
			app.use( ( req, res, next ) => {
				const err = new Error( 'Not Found' )
				err.status = 404
				next( err )
			} )
	
			app.use( ( err, req, res, next ) => {
				res.locals.message = err.message
				res.locals.error = req.app.get( 'env' ) === 'development' ? err : {}
	
				if ( err && err.code ) {
					res.status( err.code || 500 ).json( err )
				} else {
					res.status( err.code || 500 ).json( { code: 'error', message: err.message, error: err } )
				}
			} )
	
			// const httpServer = http.createServer( app )
			const httpServer = stoppable( http.createServer( app ) )
			httpServer.on( 'error', error => {
				if ( error.syscall !== 'listen' ) {
					return reject( error )
				}
	
				var bind = typeof config.port === 'string' ?
					'Pipe ' + config.port :
					'Port ' + config.port;
	
				switch ( error.code ) {
					case 'EACCES':
						console.error( bind + ' requires elevated privileges' );
						process.exit( 1 );
						break;
					case 'EADDRINUSE':
						console.error( bind + ' is already in use' );
						process.exit( 1 );
						break;
					default:
						return reject( error )
				}
			} )
	
			httpServer.on( 'listening', () => {
				var addr = httpServer.address()
				var bind = typeof addr === 'string' ?
					'pipe ' + addr :
					'port ' + addr.port
	
				return resolve( 'Listening on ' + bind )
			} )
	
			httpServer.listen( app.get( 'port' ) )
		})
	}

	app.Router = () => {
		return express.Router()
	}

	function shutdown( signal ) {
		console.info( `shutting down...` )
		process.exit()
	}
	
	process.on( 'SIGINT', () => shutdown( 'SIGINT' ) )
	process.on( 'SIGTERM', () => shutdown( 'SIGTERM' ) )
	
	return app
}

function normalizePort( val ) {
	var port = parseInt( val, 10 );

	if ( isNaN( port ) ) {
		return val
	}

	if ( port >= 0 ) {
		return port
	}

	return false
}

module.exports = {
	server
}