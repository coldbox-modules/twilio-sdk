component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Number Lookup", function() {
            beforeEach( function() {
                variables.twilioClient = getInstance( "TwilioClient@twilio-sdk" );
            } );

            afterEach( function() {
                structDelete( variables, "twilioClient" );
            } );

            it( "can look up a phone number", function() {
                var res = twilioClient.lookupPhoneNumber( "415-701-2311", false )
                    .withBasicAuth(
                        getSystemSetting( "TWILIO_ACCOUNT_SID" ),
                        getSystemSetting( "TWILIO_AUTHTOKEN" )
                    )
                    .send();

                expect( res.getStatusCode() ).toBe( 200, "Response should be a 201 Created" );
                expect( res.json().national_format ).toBe( "(415) 701-2311" );
            } );

            it( "sends a 404 when the phone number is invalid", function() {
                var res = twilioClient.lookupPhoneNumber( "212555236", false )
                    .withBasicAuth(
                        getSystemSetting( "TWILIO_ACCOUNT_SID" ),
                        getSystemSetting( "TWILIO_AUTHTOKEN" )
                    )
                    .send();

                expect( res.getStatusCode() ).toBe( 404, "Response should be a 404 Not Found" );
            } );
        } );
    }

}
