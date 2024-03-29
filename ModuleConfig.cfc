component {

	// Module Properties
	this.title       = "cfPlaid";
	this.author      = "Michael Born <michael@ortussolutions.com>";
	this.webURL      = "https://www.ortussolutions.com";
	this.description = "Handle Plaid API connections";

	// Model Namespace
	this.modelNamespace = "cfPlaid";

	// CF Mapping
	this.cfmapping = "cfPlaid";

	// Dependencies
	this.dependencies = [ "hyper" ];

	/**
	 * Configure Module
	 */
	function configure(){
		variables.settings = {
			api_url : getSystemSetting(
				"PLAID_URL",
				"https://sandbox.plaid.com"
			),
			// You can retrieve this from https://dashboard.plaid.com/team/keys
			api_client_id     : getSystemSetting( "PLAID_CLIENT_ID", "none" ),
			// You can retrieve this from https://dashboard.plaid.com/team/keys
			api_client_secret : getSystemSetting( "PLAID_CLIENT_SECRET", "none_defined" )
		};

		binder
			.mapDirectory( "cfPlaid.models.endpoints" )
			.asSingleton();

        binder.map( "PlaidClient@cfPlaid" )
            .to( "hyper.models.HyperBuilder" )
            .asSingleton()
            .initWith(
                baseUrl = settings.api_url,
                headers = {
					  "PLAID-CLIENT-ID"    : settings.api_client_id
					, "PLAID-SECRET"       : settings.api_client_secret
                }
            );
	}

}
