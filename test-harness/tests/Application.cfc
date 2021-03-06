/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component{

	// UPDATE THE NAME OF THE MODULE IN TESTING BELOW
	request.MODULE_NAME = "cfPlaid";
	request.MODULE_PATH = "";

	// APPLICATION CFC PROPERTIES
	this.name 				= "#request.MODULE_NAME# Testing Suite";
	this.sessionManagement 	= true;
	this.sessionTimeout 	= createTimeSpan( 0, 0, 15, 0 );
	this.applicationTimeout = createTimeSpan( 0, 0, 15, 0 );
	this.setClientCookies 	= true;

	// Create testing mapping
	this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );

	// The application root
	rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
	this.mappings[ "/root" ]   			= rootPath;

	// The module root path
	moduleRootPath = REReplaceNoCase( rootPath, "#request.MODULE_PATH#(\\|/)test-harness(\\|/)", "" );
	this.mappings[ "/#request.MODULE_NAME#" ] 	= moduleRootPath & "#request.MODULE_PATH#";
	this.mappings[ "/hyper" ] 	= moduleRootPath & "/modules/hyper";

	this.mappings[ "/moduleroot" ] 				= moduleRootPath;

	// the coldbox app manually registers and activates this module, and the ModuleService only registers the module if you pass the path of the directory which CONTAINS the module directory - apparantely it'll error if you pass the module directory itself.
	this.mappings[ "/stupidcoldboxmoduleinvocationpath" ] = reReplaceNoCase( moduleRootPath, "(\\|/)#request.MODULE_NAME#", "" );

	// ORM Definitions
	/**
	this.datasource = "coolblog";
	this.ormEnabled = "true";
	this.ormSettings = {
		cfclocation = [ "/root/models" ],
		logSQL = true,
		dbcreate = "update",
		secondarycacheenabled = false,
		cacheProvider = "ehcache",
		flushAtRequestEnd = false,
		eventhandling = true,
		eventHandler = "cborm.models.EventHandler",
		skipcfcWithError = false
	};
	**/

	function onRequestStart( required targetPage ){

		if( url.keyExists( "fwreinit" ) ){
			ormreload();
			if( StructKeyExists( server, "lucee" ) ){
				pagePoolClear();
			}
		}

		// Cleanup
		if( !isNull( application.cbController ) ){
			application.cbController.getLoaderService().processShutdown();
		}
		structDelete( application, "cbController" );
		structDelete( application, "wirebox" );

		return true;
	}

	public function onRequestEnd(){
		structDelete( application, "cbController" );
		structDelete( application, "wirebox" );
	}
}