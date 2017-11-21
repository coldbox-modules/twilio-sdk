/**
 * Interact with the Twilio API
 */
component accessors="true" {

    /**
     * The configured account SID.
     * This can be overridden for subaccounts.
     */
    property name="accountSID" inject="coldbox:setting:accountSID@twilio-sdk";
    property name="wirebox" inject="wirebox" setter="false";

    function lookupPhoneNumber( phoneNumber, send = true ) {
        var req = variables.newRequest()
            .setBaseUrl( "https://lookups.twilio.com" )
            .setUrl( "/v1/PhoneNumbers/#phoneNumber#" );

        if ( send ) {
            return req.send();
        }

        return req;
    }

    function createSMS( to, from, body ) {
        return variables.newRequest()
            .setMethod( "POST" )
            .setUrl( "/Accounts/#accountSID#/Messages.json" )
            .setBody( {
                "From" = arguments.from,
                "To"   = arguments.to,
                "Body" = arguments.body
            } );
    }

    function sendSMS( to, from, body ) {
        return createSMS( argumentCollection = arguments ).send();
    }

    function newRequest() {
        return wirebox.getInstance( "TwilioHyperClient@twilio-sdk" );
    }

    function onMissingMethod( missingMethodName, missingMethodArguments ) {
        return invoke( variables.newRequest(), missingMethodName, missingMethodArguments );
    }

}
