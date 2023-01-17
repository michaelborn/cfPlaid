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
	 * @access_token Required Plaid access token.
	 * @options.start_date Filter by transactions after or on this date. MUST be in YYYY-MM-DD format.
	 * @options.end_date Filter by transactions before or on this date. MUST be in YYYY-MM-DD format.
	 */
	public struct function getBalances( required string access_token, struct options = {} ){
		return plaidClient
			.asJSON()
			.setBody( {
				"options"     : arguments.options,
				"access_token": arguments.access_token
			} )
			.post( "/accounts/balance/get" );
	}

	/**
	 * Retrieve Plaid accounts
	 *
	 * See Plaid API docs
	 * @see https://plaid.com/docs/api/accounts/#accountsget
	 *
	 * @access_token Required Plaid access token.
	 */
	public struct function getAccounts( required string access_token, struct options = {} ){
		return plaidClient
			.asJSON()
			.setBody( {
				"options"     : arguments.options,
				"access_token": arguments.access_token
			} )
			.post( "/accounts/get" );
	}

}
