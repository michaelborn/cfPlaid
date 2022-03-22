/**
 * Test the cfPlaid module config and wiring.
 */
component extends="coldbox.system.testing.BaseTestCase" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();

		// var moduleService = getController().getModuleService();

        // if( !moduleService.isModuleRegistered( "cfPlaid" ) ){
        //     moduleService.registerAndActivateModule( "cfPlaid" );
        // }
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
		describe( "cfplaid.ModuleConfig", function(){
			describe( "onLoad", function(){
				it( "should set up PlaidClient@cfPlaid", function(){
					var plaidClient = getWirebox().getInstance( "PlaidClient@cfPlaid" );

                    expect( plaidClient ).toBeInstanceOf( "hyper.models.HyperBuilder" );
				} );
			} );
		} );
	}

}
