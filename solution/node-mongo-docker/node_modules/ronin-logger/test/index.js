const log = require( '..' )

function logTest() {
	log.setlevel()

	console.log( '\n*** LOG ***' )
	log.log( 'this is a log message' )
	log.debug( 'this is a debug message' )
	log.info( 'this is an info message' )
	log.warn( 'this is a warn message' )
	log.error( 'this is an error message' )
}

function debugTest() {
	log.setlevel( log.LEVELS.DEBUG )

	console.log( '\n*** DEBUG ***' )
	log.log( 'this is a log message' )
	log.debug( 'this is a debug message' )
	log.info( 'this is an info message' )
	log.warn( 'this is a warn message' )
	log.error( 'this is an error message' )
}

function infoTest() {
	log.setlevel( log.LEVELS.INFO )

	console.log( '\n*** INFO ***' )
	log.log( 'this is a log message' )
	log.debug( 'this is a debug message' )
	log.info( 'this is an info message' )
	log.warn( 'this is a warn message' )
	log.error( 'this is an error message' )
}

function warnTest() {
	log.setlevel( log.LEVELS.WARN )

	console.log( '\n*** WARN ***' )
	log.log( 'this is a log message' )
	log.debug( 'this is a debug message' )
	log.info( 'this is an info message' )
	log.warn( 'this is a warn message' )
	log.error( 'this is an error message' )
}

function errorTest() {
	log.setlevel( log.LEVELS.ERROR )

	console.log( '\n*** ERROR ***' )
	log.log( 'this is a log message' )
	log.debug( 'this is a debug message' )
	log.info( 'this is an info message' )
	log.warn( 'this is a warn message' )
	log.error( 'this is an error message' )
}

logTest()
debugTest()
infoTest()
warnTest()
errorTest()

