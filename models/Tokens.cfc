/**
 * Handle Plaid API access tokens.
 */
component extends="BaseRequest" {

	/**
	 * Create a Plaid link token.
	 * i.e., request an access token in this important first step
	 * to establishing a working relationship with Plaid.
	 * See Plaid docs - https://plaid.com/docs/api/tokens/#linktokencreate
	 */
	public struct function createLink( required string redirectURI ){
		return handleResponse(
			hyper.post(
				url  = settings.api_url & "/link/token/create",
				body = {
					"client_id"     : settings.api_client_id,
					"secret"        : settings.api_client_secret,
					"client_name"   : "cbFlannel",
					"language"      : "en",
					"country_codes" : [ "US" ],
					"products"      : [ "transactions" ],
					"user"          : { "client_user_id" : "MB-test123" },
					"redirect_uri"  : arguments.redirectURI
				}
			)
		);
	}

	/**
	 * Exchange a public_token for an access_token
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/tokens/#itempublic_tokenexchange
	 */
	public struct function exchangeToken( required string public_token ){
		return handleResponse(
			hyper.post(
				url  = settings.api_url & "/item/public_token/exchange",
				body = {
					"client_id"    : settings.api_client_id,
					"secret"       : settings.api_client_secret,
					"public_token" : arguments.public_token
				}
			)
		);
	}

	/**
	 * Rotate an access_token for security reasons.
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/tokens/#itemaccess_tokeninvalidate
	 */
	public struct function invalidateToken( required string access_token ){
		return handleResponse(
			hyper.post(
				url  = settings.api_url & "/item/access_token/invalidate",
				body = {
					"client_id"    : settings.api_client_id,
					"secret"       : settings.api_client_secret,
					"access_token" : arguments.access_token
				}
			)
		);
	}

	/**
	 * Retreive Plaid token metadata
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/tokens/#linktokenget
	 */
	public struct function getLinkToken( required string access_token ){
		return handleResponse(
			hyper.post(
				url  = settings.api_url & "/link/token/get",
				body = {
					"client_id"    : settings.api_client_id,
					"secret"       : settings.api_client_secret,
					"access_token" : arguments.access_token
				}
			)
		);
	}

}
