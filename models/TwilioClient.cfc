/**
 * Interact with the Twilio API
 */
component singleton accessors="true" {

    /**
     * The configured account SID.
     * This can be overridden for subaccounts.
     */
    property name="accountSID" inject="box:setting:accountSID@twilio-sdk";

    /**
     * A configured HyperBuilder client to use with the Twilio API.
     * This is handled for you when using as a ColdBox module.
     */
    property name="hyperClient" inject="TwilioHyperClient@twilio-sdk";

    /**
     * Look up information about a phone number.
     *
     * @phoneNumber    The phone number to look up.
     * @withCallerName Should caller information be included in the response.
     *                 (This costs extra.) [Deprecated in favor of @type] Default: false.
     * @types          An optional array of types of information to be
     *                 included in the response. Options include 'carrier'
     *                 and 'caller-name'. (This costs extra.)
     * @addons         An optional array of addons to process and include
     *                 in the response. (This may cost extra.)
     *
     * @returns        A configured HyperRequest instance.
     */
    function lookup(
        phoneNumber,
        withCallerName = false,
        types = [],
        addons = []
    ) {
        var req = newRequest()
            .setBaseUrl( "https://lookups.twilio.com" )
            .setUrl( "/v1/PhoneNumbers/#trim( arguments.phoneNumber )#" );

        if ( arguments.withCallerName ) {
            req.appendQueryParam( "Type", "caller-name" );
        }

        for ( var type in arguments.types ) {
            req.appendQueryParam( "Type", type );
        }

        for ( var addon in arguments.addons ) {
            req.appendQueryParam( "AddOns", addon );
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
            .setBody( { "From": arguments.from, "To": arguments.to, "Body": escapeNewlineCharacters( arguments.body ) } );
    }

    /**
     * Initiate a phone call
     *
     * @to                The phone number the call is going to.
     * @from              The phone number the call is from.
     *                    This must be a valid Twilio number.
     * @twiml             The twiml XML instructions for the call.
     * @additionalParams  Any additional param to send with the request
     *
     * @returns           A configured HyperRequest instance.
     */
    function call(
        required string to,
        required string from,
        required string twiml,
        struct additionalParams = {}
    ) {
        var body = { "From": arguments.from, "To": arguments.to, "Twiml": arguments.twiml };
        structAppend( body, additionalParams );

        return newRequest()
            .setMethod( "POST" )
            .setUrl( "/Accounts/#variables.accountSID#/Calls.json" )
            .setBody( body );
    }

    function newRequest() {
        return hyperClient.new();
    }

    function onMissingMethod( missingMethodName, missingMethodArguments ) {
        return invoke( newRequest(), missingMethodName, missingMethodArguments );
    }

    private string function escapeNewlineCharacters( required string s ) {
        return replace( arguments.s, "\n", chr( 10 ), "all" );
    }

}
