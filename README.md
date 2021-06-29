# cfPlaid

Integrate with the [Plaid API](https://plaid.com/docs/api/) from CFML.

## Features

## Setup

1. Install this module in your app - `box install cfPlaid`
2. Add the required configuration either via environment variables or module settings

## Configuration

### Env File and `commandbox-dotenv`

```bash
# Plaid API creds
PLAID_URL=https://sandbox.plaid.com

# Uh... this might be fake.
PLAID_USERNAME=fakey_fakey
PLAID_PASSWORD=you_cannot_pass

# Plaid keys
PLAID_CLIENT_ID=123_FIXME
PLAID_CLIENT_SECRET=456_FIXME
```

### Module Settings

Add the following to `config/ColdBox.cfc` and update as necessary:

```js
moduleSettings = {
    cfPlaid = {
        api_uri          : "https://sandbox.plaid.com",
        api_user         : "user-FIXME",
        api_pass         : "pass-FIXME",
        api_client_id    : "123_FIXME",
        api_client_secret: "456_FIXME"
    }
}
```