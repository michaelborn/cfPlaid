/**
 * The base model test case will use the 'model' annotation as the instantiation path
 * and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
 * responsibility to update the model annotation instantiation path and init your model.
 */
component extends="coldbox.system.testing.BaseModelTest" model="models.Accounts" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();

		// setup the model
		super.setup();

		variables.plaidAPISettings = {
			api_url           : "http://localhost",
			api_client_id     : "client-id-test-1",
			api_client_secret : "client-secret-haha"
		};

		variables.hyperMock         = getMockBox().createMock( "hyper.models.HyperBuilder" ).init(
			baseUrl = plaidAPISettings.api_url,
			body = {
				"client_id"    : plaidAPISettings.api_client_id,
				"secret"       : plaidAPISettings.api_client_secret
			}
		);
		variables.hyperResponseMock = getMockBox().createMock( "hyper.models.HyperResponse" );

		hyperMock.$(
			method             = "post",
			callLogging        = true,
			returns            = hyperResponseMock,
			preserveReturnType = true
		);

		model.$property(
			propertyName = "settings",
			mock         = variables.plaidAPISettings
		);
		model.$property(
			propertyName = "plaidClient",
			mock         = variables.hyperMock
		);

		// init the model object
		model.init();
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
		describe( "cfplaid.models.Accounts Suite", function(){
			describe( "getBalances", function(){
				it( "should fetch account balances", function(){
					variables.hyperResponseMock.$property(
						propertyName = "data",
						mock         = serializeJSON( { balances : [] } )
					);
					var result = variables.model.getBalances( access_token = "secret-123" );

					expect( result ).toBeStruct( "should return deserialized JSON" ).toHaveKey( "balances" );
				} );
			} );
		} );
	}

}
