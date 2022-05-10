# Br4n

Rails application using [H0dor](https://github.com/SebouChu/h0dor) as identity provider through OAuth2 and OpenID Connect

![br4n](https://user-images.githubusercontent.com/7761386/167664288-8b97fdde-e3dc-426a-964a-da816a8255e1.jpeg)

## Setup

You need a configured [H0dor](https://github.com/SebouChu/h0dor) instance in your work environment.

### Basic

- Clone this repo
- Run `bin/setup`
- Run `yarn`
- Install [puma-dev](https://github.com/puma/puma-dev) if you don't have it, and redirect `br4n` to port 8001
  - `echo 8001 > ~/.puma-dev/br4n`

### Environment variables

- Copy `config/application.yml.example` to `config/application.yml`
- In H0dor, create an application which will use OAuth2 for authentication
  - Attributes
    - Redirect URI: `https://br4n.localhost/users/auth/doorkeeper/callback`
    - Confidential: `true`
    - Scopes: `read`
  - Then set `DOORKEEPER_OAUTH2_APP_ID` and `DOORKEEPER_OAUTH2_APP_SECRET` with the generated UID and Secret attributes.
- Still in H0dor, create an application which will use OAuth2 for authentication
  - Attributes
    - Redirect URI: `https://br4n.localhost/users/auth/openid_connect/callback`
    - Confidential: `true`
    - Scopes: `openid email profile`
  - Then set `DOORKEEPER_OPENID_APP_ID` and `DOORKEEPER_OPENID_APP_SECRET` with the generated UID and Secret attributes.

## Run

```
bin/dev
```

Access it via https://br4n.localhost

## Info

This Rails application uses [Devise](https://github.com/heartcombo/devise) and [OmniAuth](https://github.com/doorkeeper-gem/doorkeeper) to sign in via OAuth2 and OpenID Connect thanks to [H0dor](https://github.com/SebouChu/h0dor).
