/**
* Copyright Since 2005 Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com | www.gocontentbox.org
**************************************************************************************
*/
component{
	this.name = "A TestBox Runner Suite " & hash( getCurrentTemplatePath() );
	// any other application.cfc stuff goes below:
	this.sessionManagement = true;
	// Turn on/off white space management
	this.whiteSpaceManagement = "smart";

	// any mappings go here, we create one that points to the root called test.
	testsPath = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/tests" ] = testsPath;
	rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
    this.mappings[ "/root" ]   = rootPath;
	this.mappings[ "/twilio-sdk" ]   = rootPath;
	this.mappings[ "/hyper" ]   = rootPath & "modules/hyper";
	this.mappings[ "/testingModuleRoot" ] = listDeleteAt( rootPath, listLen( rootPath, '\/' ), "\/" );
    this.mappings[ "/app" ] = testsPath & "resources/app";
    this.mappings[ "/coldbox" ] = testsPath & "resources/app/coldbox";
    this.mappings[ "/testbox" ] = rootPath & "testbox";

	// request start
	public boolean function onRequestStart( String targetPage ){
		getJavaSystem().setProperty( "TWILIO_ACCOUNT_SID", getSystemSetting( "TWILIO_TEST_ACCOUNT_SID" ) );
		getJavaSystem().setProperty( "TWILIO_AUTHTOKEN", getSystemSetting( "TWILIO_TEST_AUTHTOKEN" ) );
		return true;
	}

	/**
	 * Retrieve a Java System property or env value by name. It looks at properties first then environment variables
	 *
	 * @key          The name of the setting to look up.
	 * @defaultValue The default value to use if the key does not exist in the system properties or the env
	 *
	 * @throws SystemSettingNotFound When the java system property or env is not found
	 */
	function getSystemSetting( required key, defaultValue ){
		var value = getJavaSystem().getProperty( arguments.key );
		if ( !isNull( local.value ) ) {
			return value;
		}

		value = getJavaSystem().getEnv( arguments.key );
		if ( !isNull( local.value ) ) {
			return value;
		}

		if ( !isNull( arguments.defaultValue ) ) {
			return arguments.defaultValue;
		}

		throw(
			type   : "SystemSettingNotFound",
			message: "Could not find a Java System property or Env setting with key [#arguments.key#]."
		);
	}

	function getJavaSystem() {
		param variables.javaSystem = createObject( "java", "java.lang.System" );
		return variables.javaSystem;
	}

}
