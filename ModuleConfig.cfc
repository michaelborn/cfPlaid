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
		settings = {
			api_url : getSystemSetting(
				"PLAID_URL",
				"https://sandbox.plaid.com"
			),
			// You can retrieve this from https://dashboard.plaid.com/team/keys
			api_client_id     : getSystemSetting( "PLAID_CLIENT_ID" ),
			// You can retrieve this from https://dashboard.plaid.com/team/keys
			api_client_secret : getSystemSetting( "PLAID_CLIENT_SECRET" )
		};
	}

}
