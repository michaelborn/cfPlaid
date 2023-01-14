/**
 * Wrap all cfPlaid API calls
 * 
 * Requires modern ColdBox due to the new @delegated magic.
 */
component accessors="false" {

    property name="Accounts" inject="Accounts@cfPlaid" delegate;
    property name="Tokens" inject="Tokens@cfPlaid" delegate;
    
	public component function init(){
		return this;
	}

	/**
	 * Handle Plaid API response errors
	 *
	 * @response a HyperResponse object for the request.
	 */
	private struct function parseAndThrow( required HyperResponse response ){
		if ( response.isError() ){
			var result  = response.getData();
			var message = "Error from Plaid server";
			var type    = "PlaidCallException";
			var detail  = response.getData();

			if ( isJSON( result ) ) {
				result = response.json();
				if ( structKeyExists( result, "error_type" ) ) {
					type = result[ "error_type" ];
				}
				if ( structKeyExists( result, "error_message" ) ) {
					message = result[ "error_message" ];
				}
				if ( structKeyExists( result, "causes" ) ) {
					detail = result[ "causes" ];
				}
			}

			throw(
				message      = message,
				type         = type,
				detail       = detail,
				extendedinfo = result
			);
		}
	}

}