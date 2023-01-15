/**
 * Test the Accounts API wrapper.
 */
component extends="coldbox.system.testing.BaseModelTest" loadColdbox="true" {

    property name="credsFile" default="/cfPlaid/.PLAID_CREDENTIALS.json";
    property name="PLAID_CREDS" default="";

	function beforeAll(){
		super.beforeAll();
        
        variables.model = prepareMock( getInstance( "Client@cfPlaid" ) );
        // writeDump( getInstance( "Accounts@cfplaid" ).getSettings() );abort;

		// setup the model
		super.setup();
        if ( fileExists( credsFile ) ){
            variables.PLAID_CREDS = deserializeJSON(
                fileRead( variables.credsFile )
            );
        }
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
        describe( "cfPlaid.models.Client", function() {
            describe( "cfplaid.models.Accounts Suite", function(){
                it( "getBalances", function(){
                    var response = variables.model.getBalances( variables.PLAID_CREDS[ "access_token" ] );

                    // debug( response );
                    expect( response.isSuccess() ).tobeTrue();
                    expect( response.json() ).toHaveKey( "accounts" );
                } );
                it( "getAccounts", function(){
                    var response = variables.model.getAccounts( variables.PLAID_CREDS[ "access_token" ] );

                    // debug( response );
                    expect( response.isSuccess() ).tobeTrue();
                    expect( response.json() ).toHaveKey( "accounts" );
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
