/**
 * Handle Plaid API Asset requests
 *
 * @see https://plaid.com/docs/api/products/#assets
 */
component extends="BaseRequest" {

	/**
	 * Create an asset report.
	 *
	 * @see https://plaid.com/docs/api/products/#asset_reportcreate
	 *
	 * @access_token
	 * @days_requested The maximum integer number of days of history to include in the Asset Report. If using Fannie Mae Day 1 Certainty, days_requested must be at least 61 for new originations or at least 31 for refinancings.
	 * @options
	 */
	public struct function createReport(
		required string access_token,
		required numeric days_requested,
		struct options = {}
	){
		return handleResponse(
			hyper.post(
				url  = settings.api_url & "/asset_report/create",
				body = {
					"client_id"      : settings.api_client_id,
					"secret"         : settings.api_client_secret,
					"access_tokens"  : [ arguments.access_token ],
					"days_requested" : arguments.days_requested,
					"options"        : arguments.options
				}
			)
		);
	}

}
