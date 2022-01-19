/**
 * Handle Plaid API Item requests
 *
 * @see https://plaid.com/docs/api/items/
 */
component extends="BaseRequest" {

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
		return handleResponse(
			hyper.post(
				url  = settings.api_url & "/item/get",
				body = {
					"client_id"    : settings.api_client_id,
					"secret"       : settings.api_client_secret,
					"access_token" : arguments.access_token
				}
			)
		);
	}

}
