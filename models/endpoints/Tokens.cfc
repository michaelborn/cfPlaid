/**
 * Handle Plaid API access tokens.
 */
component accessors="false" {
    
	property name="settings"    inject="coldbox:modulesettings:cfPlaid";
	property name="plaidClient" inject="PlaidClient@cfPlaid";

	public component function init(){
		return this;
	}

	/**
	 * Create a Plaid link token.
	 * i.e., request an access token in this important first step
	 * to establishing a working relationship with Plaid.
	 * See Plaid docs - https://plaid.com/docs/api/tokens/#linktokencreate
	 */
	public struct function createLink( required string redirectURI ){
		return plaidClient
			.asJSON()
			.setBody( {
				"client_id"     : settings.api_client_id,
				"secret"        : settings.api_client_secret,
				"client_name"   : "cbFlannel",
				"language"      : "en",
				"country_codes" : [ "US" ],
				"products"      : [ "transactions" ],
				"user"          : { "client_user_id" : "MB-test123" },
				"redirect_uri"  : arguments.redirectURI
			} )
			.post( "/link/token/create" );
	}

	/**
	 * Exchange a public_token for an access_token
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/tokens/#itempublic_tokenexchange
	 */
	public struct function exchangeToken( required string public_token ){
		return plaidClient
			.asJSON()
			.setBody( {
				"public_token" : arguments.public_token
			} )
			.post( "/item/public_token/exchange" );
	}

	/**
	 * Rotate an access_token for security reasons.
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/tokens/#itemaccess_tokeninvalidate
	 */
	public struct function invalidateToken( required string access_token ){
		return plaidClient
			.asJSON()
			.setBody( {
				"access_token" : arguments.access_token
			} )
			.post( "/item/access_token/invalidate" );
	}

	/**
	 * Retreive Plaid token metadata
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/tokens/#linktokenget
	 */
	public struct function getLinkToken( required string link_token ){
		return plaidClient
			.asJSON()
			.setBody( {
				"link_token"   : arguments.link_token
			} )
			.post( "/link/token/get" );
	}

}
