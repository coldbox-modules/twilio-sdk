component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Send SMS", function() {
            beforeEach( function() {
                variables.twilioClient = getInstance( "TwilioClient@twilio-sdk" );
            } );

            afterEach( function() {
                structDelete( variables, "twilioClient" );
            } );

            it( "can send an SMS message", function() {
                var res = twilioClient.sendSMS(
                    from = "+15005550006",
                    to = "+18015550005",
                    body = "Testing 123"
                );

                expect( res.getStatusCode() ).toBe( 201, "Response should be a 201 Created" );
                expect( res.json().body ).toInclude( "Testing 123" );
            } );

            it( "can create an SMS message without sending it", function() {
                var req = twilioClient.createSMS(
                    from = "+15005550006",
                    to = "+18015550005",
                    body = "Testing 123"
                );

                expect( req ).toBeInstanceOf( "Hyper.models.HyperRequest", "req should be the HyperRequest still" );
            } );
        } );
    }

}
