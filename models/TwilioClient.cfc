/**
 * Interact with the Twilio API
 */
component singleton accessors="true" {

    /**
     * The configured account SID.
     * This can be overridden for subaccounts.
     */
    property name="accountSID" inject="coldbox:setting:accountSID@twilio-sdk";

    /**
     * A configured HyperBuilder client to use with the Twilio API.
     * This is handled for you when using as a ColdBox module.
     */
    property name="hyperClient" inject="TwilioHyperClient@twilio-sdk";

    /**
     * Look up information about a phone number.
     *
     * @phoneNumber    The phone number to look up.                                                            |
     * @withCallerName Should caller information be included in the response.
     *                 (This costs extra.) Default: false.                 |
     * @addons         An optional array of addons to process and include
     *                 in the response. (This may cost extra.)
     *
     * @returns        A configured HyperRequest instance.
     */
    function lookup(
        phoneNumber,
        withCallerName = false,
        addons = []
    ) {
        var req = newRequest()
            .setBaseUrl( "https://lookups.twilio.com" )
            .setUrl( "/v1/PhoneNumbers/#phoneNumber#" );

        if ( withCallerName ) {
            req.withQueryParams( { "Type" = "caller-name" } );
        }

        for ( var addon in addons ) {
            req.withQueryParams( { "AddOns" = addon } );
        }

        return req;
    }

    /**
     * Send an sms message.
     *
     * @to     The phone number the sms is going to.
     * @from   The phone number the sms is from.
     *         This must be a valid Twilio number.
     * @body   The body of the sms message.
     *
     * @returns A configured HyperRequest instance.
     */
    function sms( to, from, body ) {
        return newRequest()
            .setMethod( "POST" )
            .setUrl( "/Accounts/#accountSID#/Messages.json" )
            .setBody( {
                "From" = arguments.from,
                "To"   = arguments.to,
                "Body" = arguments.body
            } );
    }

    function newRequest() {
        return hyperClient.new();
    }

    function onMissingMethod( missingMethodName, missingMethodArguments ) {
        return invoke( newRequest(), missingMethodName, missingMethodArguments );
    }

}
