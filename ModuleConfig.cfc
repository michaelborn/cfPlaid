/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 */
component {

	// Module Properties
	this.title 				= "cfPlaid";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "Handle Plaid API connections";

	// Model Namespace
	this.modelNamespace		= "cfPlaid";

	// CF Mapping
	this.cfmapping			= "cfPlaid";

	// Dependencies
	this.dependencies 		= [ "hyper" ];

	/**
	 * Configure Module
	 */
	function configure(){
		settings = {
			api_uri          : server.system.environment[ "PLAID_URL" ],
			// api_user         : server.system.environment[ "PLAID_URL" ],
			// api_pass         : server.system.environment[ "PLAID_URL" ],
			
			// You can retrieve this from https://dashboard.plaid.com/team/keys
			api_client_id    : server.system.environment[ "PLAID_CLIENT_ID" ],

			// You can retrieve this from https://dashboard.plaid.com/team/keys
			api_client_secret: server.system.environment[ "PLAID_CLIENT_SECRET" ]
		};
	}

	// /**
	//  * Fired when the module is registered and activated.
	//  */
	// function onLoad(){

	// }

	// /**
	//  * Fired when the module is unregistered and unloaded
	//  */
	// function onUnload(){

	// }

}
