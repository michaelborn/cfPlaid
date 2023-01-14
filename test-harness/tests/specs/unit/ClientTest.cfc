/**
 * Test the Accounts API wrapper.
 */
component extends="coldbox.system.testing.BaseModelTest" loadColdbox="true" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
        
        variables.model = prepareMock( getInstance( "Client@cfPlaid" ) );

		// setup the model
		super.setup();

        /**
         * Kinda hard to do mocking with delegates. 😥
         */
		// variables.plaidAPISettings = {
		// 	api_url           : "http://localhost",
		// 	api_client_id     : "client-id-test-1",
		// 	api_client_secret : "client-secret-haha"
		// };

		// variables.hyperMock         = getMockBox().createMock( "hyper.models.HyperBuilder" ).init(
		// 	baseUrl = plaidAPISettings.api_url,
		// 	body = {
		// 		"client_id"    : plaidAPISettings.api_client_id,
		// 		"secret"       : plaidAPISettings.api_client_secret
		// 	}
		// );
		// variables.hyperResponseMock = getMockBox().createMock( "hyper.models.HyperResponse" );

		// hyperMock.$(
		// 	method             = "post",
		// 	callLogging        = true,
		// 	returns            = hyperResponseMock,
		// 	preserveReturnType = true
		// );

		// model.$property(
		// 	propertyName = "settings",
		// 	mock         = variables.plaidAPISettings
		// );
		// model.$property(
		// 	propertyName = "plaidClient",
		// 	mock         = variables.hyperMock
		// );
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
        describe( "cfPlaid.models.Client", function() {
            describe( "cfplaid.models.Accounts Suite", function(){
                describe( "getBalances", function(){
                    it( "should fetch account balances", function(){
                        // variables.hyperResponseMock.$property(
                        //     propertyName = "data",
                        //     mock         = serializeJSON( { balances : [] } )
                        // );
                        var response = variables.model.getBalances( access_token = "secret-123" );

                        debug( response );
                        expect( response.isSuccess() ).tobeTrue();
                        expect( response.json() ).toHaveKey( "balances" );
                    } );
                } );
            } );
            describe( "Assets Suite", function(){
            } );
            describe( "cfPlaid.models.Tokens Suite", function(){
                it( "should createLink", function(){
                    var response = variables.model.createLink();
                    expect( response.isSuccess() ).toBeTrue();
                } );
    
                it( "should exchangeToken", function(){
                    var response = variables.model.exchangeToken();
                    expect( response.isSuccess() ).toBeTrue();
                } );
    
                it( "should invalidateToken", function(){
                    var response = variables.model.invalidateToken();
                    expect( response.isSuccess() ).toBeTrue();
                } );
    
                it( "should getLinkToken", function(){
                    var response = variables.model.getLinkToken();
                    expect( response.isSuccess() ).toBeTrue();
                } );
            } );
            describe( "cfplaid.models.Transactions Suite", function(){
                it( "should getBalances", function(){
                    expect( false ).toBeTrue();
                } );
            } );
        } );
	}

}
