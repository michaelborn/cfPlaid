/**
 * Handle Plaid API Account Balance requests
 * 
 * @see https://plaid.com/docs/api/products/#balance
 */
component extends="BaseRequest"{

    /**
     * Retreive Plaid account balance data
     * 
     * See Plaid API docs
     * https://plaid.com/docs/api/products/#balance
     * 
     * @start_date Filter by transactions after or on this date. MUST be in YYYY-MM-DD format.
     * @end_date Filter by transactions before or on this date. MUST be in YYYY-MM-DD format.
     */
    public struct function getBalances(
        required string access_token,
        struct options = {}
    ){
        return handleResponse(
            hyper.post(
                url = settings.api_uri & "/accounts/balance/get",
                body = {
                    "client_id"   : settings.api_client_id,
                    "secret"      : settings.api_client_secret,
                    "access_token": arguments.access_token,
                    "options"     : arguments.options
                }
            )
        );
    }

    
}