component {

	property name="settings" inject="coldbox:modulesettings:cfPlaid";
	property name="hyper"    inject="HyperBuilder@hyper";

	public component function init(){
		return this;
	}

	/**
	 * Handle Plaid API response errors
	 *
	 * @response a HyperResponse object for the request.
	 */
	private struct function handleResponse( required HyperResponse response ){
		if ( response.isSuccess() ) {
			return response.json();
		} else {
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
				message    = message,
				type       = type,
				detail     = detail,
				extendedinfo = result
			);
		}
	}

}
