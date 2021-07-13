/**
 * Handle Plaid API transaction endpoint calls
 *
 * @see https://plaid.com/docs/api/products/#transactions
 */
component extends="BaseRequest" {

	/**
	 * Retreive Plaid transaction data for the account associated with the access_token
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/products/#transactionsget
	 *
	 * @start_date Filter by transactions after or on this date. MUST be in YYYY-MM-DD format.
	 * @end_date Filter by transactions before or on this date. MUST be in YYYY-MM-DD format.
	 */
	public struct function getTransactions(
		required string access_token,
		required string start_date,
		required string end_date,
		struct options = {}
	){
		return handleResponse(
			hyper.post(
				url  = settings.api_url & "/transactions/get",
				body = {
					"client_id"    : settings.api_client_id,
					"secret"       : settings.api_client_secret,
					"access_token" : arguments.access_token,
					"start_date"   : arguments.start_date,
					"end_date"     : arguments.end_date,
					"options"      : arguments.options
				}
			)
		);
	}

}
