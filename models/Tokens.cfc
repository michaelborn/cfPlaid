/**
 * Handle Plaid API access tokens.
 */
component extends="BaseRequest"{

    /**
     * Create a Plaid link token.
     * i.e., request an access token in this important first step 
     * to establishing a working relationship with Plaid.
     * See Plaid docs - https://plaid.com/docs/api/tokens/#linktokencreate
     */
    public struct function createLink(
        required string redirectURI
    ){
        return handleResponse(
            hyper.post(
                url = settings.api_uri & "/link/token/create",
                body = {
                    "client_id"    : settings.api_client_id,
                    "secret"       : settings.api_client_secret,
                    "client_name"  : "cbFlannel",
                    "language"     : "en",
                    "country_codes": [ "US" ],
                    "products"     : [ "transactions" ],
                    "user"         : {
                        "client_user_id" : "MB-test123"
                    },
                    "redirect_uri" : arguments.redirectURI
                }
            )
        );
    }
}