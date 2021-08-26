/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="cfplaid.models.Accounts"{

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();

		// setup the model
		super.setup();

		variables.hyperMock = getMockBox().createMock( "hyper.models.HyperBuilder");
		variables.hyperResponseMock = getMockBox().createMock( "hyper.models.HyperResponse" );

		hyperMock.$( method = "post", callLogging = true, returns=hyperResponseMock, preserveReturnType=true );

		variables.plaidAPISettings = {
			api_url          : "http://localhost",
			api_client_id    : "client-id-test-1",
			api_client_secret: "client-secret-haha"
		};
		model.$property( propertyName = "settings", mock=variables.plaidAPISettings );
		model.$property( propertyName = "hyper", mock=hyperMock );

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
				it( "should hit the account balances endpoint", function() {

					var mockResponseData = serializeJSON( { balances: [] } );
					variables.hyperResponseMock.$property( propertyName="data", mock=mockResponseData );
					var result = variables.model.getBalances(
						access_token = "token-blabla"
					);

					expect( result ).toBeStruct( "should return deserialized JSON" )
									.toHaveKey( "balances" );
					// debug( hyperMock.$callLog() );

					var balanceCall = arrayLast( hyperMock.$callLog()["post"] );
					expect( balanceCall.url ).toBe( "#variables.plaidAPISettings.api_url#/accounts/balance/get", "should hit the right API url" );
					expect( balanceCall.body.client_id ).toBe( variables.plaidAPISettings.api_client_id );
					expect( balanceCall.body.secret ).toBe( variables.plaidAPISettings.api_client_secret );
					expect( balanceCall.body.access_token ).toBe( "token-blabla" );
				});
			});


		});

	}

}
