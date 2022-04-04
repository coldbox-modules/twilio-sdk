component accessors="true" {

    /**
     * The configured account auth token.
     * This can be overridden for subaccounts.
     */
    property name="authToken" inject="box:setting:authToken@twilio-sdk";

    /**
     * Validate a request against an expected signature.
     * The expected signature should typically come from the X-Twilio-Signature header.
     *
     * @uri The full url of the request
     * @params A struct of form params, if any.
     * @expectedSignature The expected signature to compare.
     *
     * @returns True if the calculated signature matches the expected signature.
     */
    function validate( expectedSignature, uri, params = {} ) {
        var paramsArray = params.keyArray();
        paramsArray.sort( "text" );
        return hmacSha1( uri & paramsArray.map( function( key ) {
            return key & params[key];
        } ).toList( "" ) ) == expectedSignature;
    }

    private function hmacSha1( string ) {
        return toBase64(
            binaryDecode(
                HMAC( string, authToken, "HMACSHA1" ),
                "hex"
            )
        );
    }

}
