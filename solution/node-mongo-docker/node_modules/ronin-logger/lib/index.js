const os = require( 'os' )
const util = require( 'util' )
const moment = require( 'moment' )
const chalk = require( 'chalk' )

const TIMESTAMP_FORMAT = 'YYYY-MM-DDTHH:mm:ss:SSSS'

const STATUS = {
	LOG: 		'LOG',
	DEBUG: 	'DEBUG',
	INFO: 	'INFO',
	WARN: 	'WARN',
	ERROR: 	'ERROR'
}

const STATUS_COLORS = {
	[STATUS.LOG]: 	'white',
	[STATUS.DEBUG]: 'white',
	[STATUS.INFO]: 	'blue',
	[STATUS.WARN]: 	'yellow',
	[STATUS.ERROR]: 'red'
}

let loglevel = STATUS.DEBUG

function setlevel( level ) {
	loglevel = level || STATUS.DEBUG
}

function formatStatus( status ) {
	return chalk[ STATUS_COLORS[ status.toUpperCase() ] ]( status.padStart( 5, ' ' ) )
}

function formatMessage( msg ) {
	msg = msg +''
	if(
		msg && ( 
			msg.startsWith( 'OPTIONS' ) ||
			msg.startsWith( 'GET' ) ||
			msg.startsWith( 'POST' ) ||
			msg.startsWith( 'DELETE' ) ||
			msg.startsWith( 'PUT' )
		)
	) {
		return chalk.yellow( msg )
	} else {
		return msg
	}
}

function internal_log( obj ) {

	if( !obj ) return 

	const level = obj.status ? obj.status.toUpperCase() : STATUS.LOG
	console.log( `${chalk.dim(moment().format( TIMESTAMP_FORMAT ))} ${formatStatus(level)}: ${obj.__l ? '\n'+util.inspect( obj.data ) : formatMessage(obj.message)}` )
}

function log( message ) {
	message = addStatus( message, STATUS.LOG )
	return internal_log( message )
}

function debug( message ) {
	const level = loglevel || STATUS.DEBUG
	if( level.toUpperCase() === STATUS.DEBUG ) {
		message = addStatus( message, STATUS.DEBUG )
		return internal_log( message )
	} else {
		return Promise.resolve( message )
	}
}

function info( message ) {
	const level = loglevel || STATUS.DEBUG
	if( 
		level.toUpperCase() === STATUS.DEBUG || 
		level.toUpperCase() === STATUS.INFO 
	) {
		message = addStatus( message, STATUS.INFO )
		return internal_log( message )
	} else {
		return Promise.resolve( message )
	}
}

function warn( message ) {
	const level = loglevel || STATUS.DEBUG
	if( 
		level.toUpperCase() === STATUS.DEBUG || 
		level.toUpperCase() === STATUS.INFO || 
		level.toUpperCase() === STATUS.WARN 
	) {
		message = addStatus( message, STATUS.WARN )
		return internal_log( message )
	} else {
		return Promise.resolve( message )
	}
}

function error( message ) {
	const level = loglevel || STATUS.DEBUG
	if( 
		level.toUpperCase() === STATUS.DEBUG || 
		level.toUpperCase() === STATUS.INFO || 
		level.toUpperCase() === STATUS.WARN || 
		level.toUpperCase() === STATUS.ERROR
	) {
		message = addStatus( message, STATUS.ERROR )
		return internal_log( message )
	} else {
		return Promise.resolve( message )
	}
}

function addStatus( message, status ) {
	let obj
	status = status.toLowerCase()

	if( message !== null && typeof message === 'object' ) {
		obj = {
			status: status,
			data: message,
			message: message.message || null,
			__l: true
		}
	} else {
		obj = {
			status: status,
			data: null,
			message: message
		}
	}

	return obj
}

module.exports = {
	LEVELS: STATUS,
	setlevel,
	log,
	debug,
	info,
	warn,
	error
}
