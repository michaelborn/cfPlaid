/**
 * Handle Plaid API Account Balance requests
 *
 * @see https://plaid.com/docs/api/products/#balance
 */
component accessors="false" {
    
	property name="settings"    inject="coldbox:modulesettings:cfPlaid";
	property name="plaidClient" inject="PlaidClient@cfPlaid";

	public component function init(){
		return this;
	}

	/**
	 * Retrieve Plaid account balance data
	 *
	 * See Plaid API docs
	 * https://plaid.com/docs/api/products/#balance
	 *
	 * @start_date Filter by transactions after or on this date. MUST be in YYYY-MM-DD format.
	 * @end_date Filter by transactions before or on this date. MUST be in YYYY-MM-DD format.
	 */
	public struct function getBalances( struct options = {} ){
		return plaidClient
			.setBody( { "options" : arguments.options } )
			.post( "/accounts/balance/get" );
	}

}
