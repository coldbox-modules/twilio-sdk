# WELCOME TO THE COLDBOX TWILIO SDK

This module is a CFML SDK to interact with the Twilio API

## LICENSE

Apache License, Version 2.0.

## IMPORTANT LINKS

* https://github.com/coldbox-modules/twilio-sdk
* https://forgebox.io/view/twilio-sdk

## SYSTEM REQUIREMENTS

* Lucee 4.5+
* Adobe ColdFusion 11+

## Setup

Configure your Twilio credentials in the `config/ColdBox.cfc` file.

```
moduleSettings = {
    "twilio-sdk" = {
        accountSID = "",
        authToken = ""
    }
};
```

## Methods

#### lookup

Look up information about a phone number. Returns a configured `HyperRequest`
instance.

| Name           | Type          | Required? | Default | Description                                                                                      |
| -------------- | ------------- | --------- | ------- | ------------------------------------------------------------------------------------------------ |
| phoneNumber    | String        | `true`    |         | The phone number to look up                                                                      |
| withCallerName | Boolean       | `false`   | `false` | Should caller information be included in the response. (This costs extra.) [DEPRECATED]          |
| types          | Array<String> | `false`   | `[]`    | An optional array of lookup types to process and include in the response. (This may cost extra.) |
| addons         | Array<String> | `false`   | `[]`    | An optional array of addons to process and include in the response. (This may cost extra.)       |

#### sms

Send an sms message. Returns a configured `HyperRequest` instance.

| Name | Type   | Required? | Default | Description                                                           |
| ---- | ------ | --------- | ------- | --------------------------------------------------------------------- |
| to   | String | `true`    |         | The phone number the sms is going to.                                 |
| from | String | `true`    |         | The phone number the sms is from. This must be a valid Twilio number. |
| body | String | `true`    |         | The body of the sms message.                                          |

### Hyper Integration

The Twilio SDK uses the Hyper HTTP Client under the hood. This entire power is
exposed to you.

All methods on the Twilio SDK return a HyperRequest instance. This instance can
be immediately executed by calling `send`, or it can be configured further.

The following is an example of creating an SMS message but then overriding the
default URL to allow for subaccount billing.

```cfc
var req = twilioClient
  .sms( from = "+15005550006", to = "+18015550005", body = "Testing 123" )
  .setUrl( "/Accounts/#subAccountSID#/Messages.json" )
  .send();
```

Additionally, you may call any `HyperRequest` method on the `TwilioSDK` and a
new request will be created, your method called, and the result returned to you.

Hyper is so powerful in this case because it can be pre-configured with common
values. This is done for your in the `ModuleConfig.cfc`:

```cfc
binder.map( "TwilioHyperClient@twilio-sdk" )
    .to( "hyper.models.HyperBuilder" )
    .asSingleton()
    .initWith(
        username = settings.accountSID,
        password = settings.authToken,
        baseURL = "https://api.twilio.com/2010-04-01",
        bodyFormat = "formFields",
        headers = {
            "Content-Type" = "application/x-www-form-urlencoded"
        }
    );
```

Because of Hyper, you don't have to specify those parameters every request. 👍

### Non-ColdBox App

In a non-ColdBox application, you'll need to initialize the models and settings
yourself, like so:

```cfc
var hyperClient = new Hyper.models.HyperBuilder(
    username = accountSID,
    password = authToken,
    baseURL = "https://api.twilio.com/2010-04-01",
    bodyFormat = "formFields",
    headers = {
        "Content-Type" = "application/x-www-form-urlencoded"
    }
);

// store in some sort of singleton scope
application.twilioClient = new twilio-sdk.models.TwilioClient();
application.twilioClient.setAccountSID( accountSID );
application.twilioClient.setHyperClient( hyperClient );

// use as normal
var lookupInfo = application.twilioClient.lookupPhoneNumber( "415-701-2311" );
```

```
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
```

#### HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't
read it, its not for you.

> "Therefore being justified by faith, we have peace with God through our Lord
> Jesus Christ: By whom also we have access by faith into this grace wherein we
> stand, and rejoice in hope of the glory of God. And not only so, but we glory
> in tribulations also: knowing that tribulation worketh patience; And patience,
> experience; and experience, hope: And hope maketh not ashamed; because the
> love of God is shed abroad in our hearts by the Holy Ghost which is given unto
> us. ." Romans 5:5

### THE DAILY BREAD

> "I am the way, and the truth, and the life; no one comes to the Father, but by
> me (JESUS)" Jn 14:1-12
