# twilio-sdk

[![Master Branch Build Status](https://img.shields.io/travis/elpete/twilio-sdk/master.svg?style=flat-square&label=master)](https://travis-ci.org/elpete/twilio-sdk)

## CFML SDK to interact with the Twilio API

### Methods

#### lookup

Look up information about a phone number. Returns a configured `HyperRequest`
instance.

| Name           | Type          | Required? | Default | Description                                                                                |
| -------------- | ------------- | --------- | ------- | ------------------------------------------------------------------------------------------ |
| phoneNumber    | String        | `true`    |         | The phone number to look up                                                                |
| withCallerName | Boolean       | `false`   | `false` | Should caller information be included in the response. (This costs extra.)                 |
| addons         | Array<String> | `false`   | `[]`    | An optional array of addons to process and include in the response. (This may cost extra.) |

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

```js
var req = twilioClient
  .sms((from = "+15005550006"), (to = "+18015550005"), (body = "Testing 123"))
  .setUrl("/Accounts/#subAccountSID#/Messages.json")
  .send();
```

Additionally, you may call any `HyperRequest` method on the `TwilioSDK` and a
new request will be created, your method called, and the result returned to you.

Hyper is so powerful in this case because it can be pre-configured with common
values. This is done for your in the `ModuleConfig.cfc`:

```js
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

```js
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
