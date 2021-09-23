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
			plaidClient.post(
				url  = "/transactions/get",
				body = {
					"start_date" : arguments.start_date,
					"end_date"   : arguments.end_date,
					"options"    : arguments.options
				}
			)
		);
	}

}
