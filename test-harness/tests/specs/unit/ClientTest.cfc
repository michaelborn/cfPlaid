/**
 * Test the Accounts API wrapper.
 */
component extends="coldbox.system.testing.BaseModelTest" loadColdbox="true" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
        
        variables.model = prepareMock( getInstance( "Client@cfPlaid" ) );
        // writeDump( getInstance( "Accounts@cfplaid" ).getSettings() );abort;

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
                    var response = variables.model.createLink(
                        redirectURI = "http://localhost:9999/accounts/connect"
                    );
                    if ( !response.isSuccess() ){
                        variables.model.parseAndThrow( response );
                    }
                    // debug( response );
                    expect( response.isSuccess() ).toBeTrue();
                    expect( response.json() )
                        .toHaveKey( "expiration" )
                        .toHaveKey( "request_id")
                        .toHaveKey( "link_token" );

                    variables.link = response.json();
                } );

                /**
                 * This could potentially be run via a UI/UX testing library like cbPlaywright
                 */
                xit( "should connect to Plaid in view", function() {
                    var html = getInstance( "Renderer@coldbox" ).view(
                        view = "plaidLink",
                        args = { "linkToken" : variables.link[ "link_token" ] } 
                    );

                    writeOutput( html );//abort;

                    // TODO: Use Playwright to run and "click" through the Plaid connection dialog

                    // Once completed, we'll set a public token for the other tests...
                    // something like this:
                    // variables.publicToken = "public-sandbox-b8054e74-8168-4711-828d-6665c6b7e17a";
                });
    
                xit( "should exchangeToken", function(){
                    var response = variables.model.exchangeToken( publicToken );

                    if ( !response.isSuccess() ){
                        variables.model.parseAndThrow( response );
                    }
                    // debug( response );
                    expect( response.isSuccess() ).toBeTrue();
                    expect( response.json() ).toHaveKey( "access_token" );

                    variables.token = response.json();
                } );
    
                xit( "should getLinkToken", function(){
                    var response = variables.model.getLinkToken( variables.token[ "access_token" ] );

                    if ( !response.isSuccess() ){
                        variables.model.parseAndThrow( response );
                    }
                    debug( response );
                    expect( response.isSuccess() ).toBeTrue();
                    expect( response.json() ).toHaveKey( "metadata" );
                } );
    
                xit( "should invalidateToken", function(){
                    var response = variables.model.invalidateToken( variables.token[ "access_token" ] );

                    if ( !response.isSuccess() ){
                        variables.model.parseAndThrow( response );
                    }
                    debug( response );
                    expect( response.isSuccess() ).toBeTrue();
                    expect( response.json() ).toHaveKey( "new_access_token" );
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
