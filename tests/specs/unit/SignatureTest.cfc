component extends="testbox.system.BaseSpec" {

    function run() {
        describe( "calculating and verifying signatures", function() {
            it( "returns true for a valid signature", function() {
                var validator = new "twilio-sdk.models.SignatureValidator"();
                validator.setAuthToken("12345");
                var uri = "https://mycompany.com/myapp.php?foo=1&bar=2";
                var formParams = {
                    "From" = "+14158675310",
                    "To" = "+18005551212",
                    "CallSid" = "CA1234567890ABCDE",
                    "Caller" = "+14158675310",
                    "Digits" = "1234"
                };
                var expectedSignature = "GvWf1cFY/Q7PnoempGyD5oXAezc=";
                expect( validator.validate( expectedSignature, uri, formParams ) )
                    .toBeTrue( "Signature should have validated correctly" );
            } );

            it( "returns false for an invalid signature", function() {
                var validator = new "twilio-sdk.models.SignatureValidator"();
                validator.setAuthToken("12345");
                var uri = "https://mycompany.com/myapp.php?foo=1&bar=2";
                var formParams = {
                    "From" = "+14158675310",
                    "To" = "+18005551212",
                    "CallSid" = "CA1234567890ABCDE",
                    "Caller" = "+14158675310",
                    "Digits" = "1234"
                };
                var invalidSignature = "invalid";
                expect( validator.validate( invalidSignature, uri, formParams ) )
                    .toBeFalse( "Signature should not have validated correctly" );
            } );
        } );
    }

}
