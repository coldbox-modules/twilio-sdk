component {

    this.name = "twilio-sdk";
    this.author = "";
    this.webUrl = "https://github.com/elpete/twilio-sdk";
    this.dependencies = [ "hyper" ];

    function configure() {
        settings = {
            accountSID: getSystemSetting( "TWILIO_ACCOUNT_SID", "" ),
            authToken: getSystemSetting( "TWILIO_AUTHTOKEN", "" )
        };
    }

    function onLoad() {
        binder
            .map( "TwilioHyperClient@twilio-sdk" )
            .to( "hyper.models.HyperBuilder" )
            .asSingleton()
            .initWith(
                username = settings.accountSID,
                password = settings.authToken,
                baseURL = "https://api.twilio.com/2010-04-01",
                bodyFormat = "formFields",
                headers = { "Content-Type": "application/x-www-form-urlencoded" }
            );
    }

}
