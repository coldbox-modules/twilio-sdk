component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Call", function() {
            beforeEach( function() {
                variables.twilioClient = getInstance( "TwilioClient@twilio-sdk" );
            } );

            afterEach( function() {
                structDelete( variables, "twilioClient" );
            } );

            it( "can make a phone call", function() {
                var res = twilioClient
                    .call(
                        from = "+15005550006",
                        to = "+18015550005",
                        twiml = "<?xml version=""1.0"" encoding=""UTF-8""?><Response><Say>Hi, there! Goodbye.</Say></Response>"
                    )
                    .send();

                expect( res.getStatusCode() ).toBe( 201, "Response should be a 201 Created" );

                expect( res.json().from ).toInclude( "+15005550006" );
                expect( res.json().to ).toInclude( "+18015550005" );
            } );
        } );
    }

}
