const log = require( 'ronin-logger' )

module.exports = {
  UnauthorizedError,
  ForbiddenError,
  MissingParameterError,
  InternalServerError
}

function base( code, message ) {
  const error = new Error( message )
  error.code = code
  return error 
}

function UnauthorizedError( msg = 'Unauthorized' ) {
  return base( 401, msg )
}

function ForbiddenError( msg = 'Forbidden' ) {
  return base( 403, msg )
}

function MissingParameterError( msg ) {
  return base( 409, msg )
}

function InternalServerError( msg ) {
  return base( 500, msg )
}
