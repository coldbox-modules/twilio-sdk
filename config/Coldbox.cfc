component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "Development Shell",

			//Development Settings
			reinitPassword			= "",
			handlersIndexAutoReload = true,

			//Implicit Events
			defaultEvent			= "main.index",
			requestStartHandler		= "",
			requestEndHandler		= "",
			applicationStartHandler = "main.onAppInit",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			ApplicationHelper 				= "",
			coldboxExtensionsLocation 	= "",
			modulesExternalLocation		= [],
			pluginsExternalLocation 	= "",
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",

			//Error/Exception Handling
			exceptionHandler		= "",
			onInvalidEvent			= "",
			customErrorTemplate		= "/coldbox/system/exceptions/BugReport.cfm",

			//Application Aspects
			handlerCaching 			= false,
			eventCaching			= false,
			proxyReturnCollection 	= false
		};

		// custom settings
		settings = {
        };

        moduleSettings = {
            "twilio-sdk" = {
                "accountSID" = getSystemSetting( "TWILIO_TEST_ACCOUNT_SID" ),
                "authToken" = getSystemSetting( "TWILIO_TEST_AUTHTOKEN" )
            }
        };

		// Activate WireBox
		wirebox = { enabled = true, singletonReload = false };

		// Module Directives
		modules = {
			//Turn to false in production, on for dev
			autoReload = false
		};

		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				files={class="coldbox.system.logging.appenders.RollingFileAppender",
					properties = {
						filename = "app", filePath="/#appMapping#/logs"
					}
				}
			},
			// Root Logger
			root = { levelmax="DEBUG", appenders="*" },
			// Implicit Level Categories
			info = [ "coldbox.system" ]
		};

		//Register interceptors as an array, we need order
		interceptors = [];
    }

    function getSystemSetting( name, defaultValue ) {
        param variables.javaSystem = createObject( "java", "java.lang.System" );

        var envValue = variables.javaSystem.getEnv( name );
        if ( ! isNull( envValue ) ) {
            return envValue;
        }

        var propValue = variables.javaSystem.getProperty( name );
        if ( ! isNull( propValue ) ) {
            return propValue;
        }

        if ( ! isNull( defaultValue ) ) {
            return defaultValue;
        }

        throw( "No environment variable or system property found for [#name#]" );
    }

}
