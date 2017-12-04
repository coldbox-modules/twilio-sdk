component extends="coldbox.system.testing.BaseTestCase" {

    function beforeAll() {
        super.beforeAll();

        getController().getModuleService()
            .registerAndActivateModule( "twilio-sdk", "testingModuleRoot" );
    }

    /**
    * @beforeEach
    */
    function setupIntegrationTest() {
        setup();
    }

    function getSystemSetting( name, defaultValue ) {
        var system = createObject( "java", "java.lang.System" );

        var envValue = system.getEnv( name );
        if ( ! isNull( envValue ) ) {
            return envValue;
        }

        var propValue = system.getProperty( name );
        if ( ! isNull( propValue ) ) {
            return propValue;
        }

        if ( ! isNull( defaultValue ) ) {
            return defaultValue;
        }

        throw( "No environment variable or system property found for [#name#]" );
    }

}
