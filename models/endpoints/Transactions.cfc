/**
 * Handle Plaid API transaction endpoint calls
 *
 * @see https://plaid.com/docs/api/products/#transactions
 */
component accessors="false" {
    
	property name="settings"    inject="coldbox:modulesettings:cfPlaid";
	property name="plaidClient" inject="PlaidClient@cfPlaid";

	public component function init(){
		return this;
	}

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
		return plaidClient
			.asJSON()
			.setBody( {
				"start_date" : arguments.start_date,
				"end_date"   : arguments.end_date,
				"options"    : arguments.options,
				"access_token" : arguments.access_token
			} )
			.post( "/transactions/get" );
	}

}
