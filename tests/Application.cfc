/**
 * Copyright Since 2005 Ortus Solutions, Corp
 * www.coldbox.org | www.luismajano.com | www.ortussolutions.com | www.gocontentbox.org
 **************************************************************************************
 */
component {

    this.name = "A TestBox Runner Suite " & hash( getCurrentTemplatePath() );
    // any other application.cfc stuff goes below:
    this.sessionManagement = true;
    // Turn on/off white space management
    this.whiteSpaceManagement = "smart";

    // any mappings go here, we create one that points to the root called test.
    testsPath = getDirectoryFromPath( getCurrentTemplatePath() );
    this.mappings[ "/tests" ] = testsPath;
    rootPath = reReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
    this.mappings[ "/root" ] = rootPath;
    this.mappings[ "/twilio-sdk" ] = rootPath;
    this.mappings[ "/hyper" ] = rootPath & "modules/hyper";
    this.mappings[ "/testingModuleRoot" ] = listDeleteAt( rootPath, listLen( rootPath, "\/" ), "\/" );
    this.mappings[ "/app" ] = testsPath & "resources/app";
    this.mappings[ "/coldbox" ] = testsPath & "resources/app/coldbox";
    this.mappings[ "/testbox" ] = rootPath & "testbox";

    // request start
    public boolean function onRequestStart( String targetPage ) {
        return true;
    }

}
