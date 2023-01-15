/**
 * Handle Plaid API Item requests
 *
 * @see https://plaid.com/docs/api/items/
 */
component accessors="false" {
    
	property name="settings"    inject="coldbox:modulesettings:cfPlaid";
	property name="plaidClient" inject="PlaidClient@cfPlaid";

	public component function init(){
		return this;
	}

	/**
	 * Retrieve an Item
	 * Returns information about the status of an Item.
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/items/#itemget
	 *
	 */
	public struct function getItem(
		required string access_token,
		struct options = {}
	){
		return plaidClient
			.setBody( {
				"client_id"    : settings.api_client_id,
				"secret"       : settings.api_client_secret,
				"access_token" : arguments.access_token
			} )
			.post( "/item/get" );
	}

}
