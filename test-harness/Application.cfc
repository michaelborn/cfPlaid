component {

    this.name = "ColdBoxTestingSuite" & hash(getCurrentTemplatePath());
    this.sessionManagement  = true;
    this.setClientCookies   = true;
    this.sessionTimeout     = createTimeSpan( 0, 0, 15, 0 );
    this.applicationTimeout = createTimeSpan( 0, 0, 15, 0 );

    thisAppPath = getDirectoryFromPath( getCurrentTemplatePath() );
    rootPath = REReplaceNoCase( thisAppPath, "test-harness(\\|/)", "" );
    this.mappings[ "/tests" ] = thisAppPath & "tests";
    this.mappings[ "/root" ] = rootPath;
    this.mappings[ "/cfplaid" ] = rootPath;
    this.mappings[ "/models" ] = rootPath & "models";
    this.mappings[ "/hyper" ] = rootPath & "modules/hyper";
    this.mappings[ "/testingModuleRoot" ] = listDeleteAt( rootPath, listLen( rootPath, '\/' ), "\/" );
    this.mappings[ "/app" ] = thisAppPath & "resources/app";
    this.mappings[ "/coldbox" ] = thisAppPath & "resources/app/coldbox";
    this.mappings[ "/testbox" ] = rootPath & "/testbox";
}