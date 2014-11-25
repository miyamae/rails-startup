Rails4 Application Template
===========================

[![Build Status](https://travis-ci.org/miyamae/rails-startup.svg)](https://travis-ci.org/miyamae/rails-startup)

Base for usual Rails applications.

## Description

* Bootstrap & AdminLTE & Font Awasome - CSS framework
* Devise & OmniAuth & CanCanCan - authentication
* Paperclip - File upload (local or S3)
* Garage - REST API with OAuth
* RSpec & Turnip & Poltergeist - E2E testing
* Capistrano - deploying
* Contact form
* Static content pages
* Admin interface
* I18n
* support Travis CI
* support Heroku

## Demo

[http://rails-startup.herokuapp.com/](http://rails-startup.herokuapp.com/)

## REST API

Sign in as admin user. Create test application.

```
open http://localhost:3000/oauth/applications
```

Get access token.

```
curl -H "Accept: application/json" \
  -F grant_type=client_credentials \
  -F client_id=$APPLICTION_ID \
  -F client_secret=$APPLICATION_SECRET \
  -X POST http://localhost:3000/oauth/token
```

Or password authorization.

```
curl -H "Accept: application/json" \
  -F grant_type=password \
  -F username=user@example.com \
  -F password=PASSWORD \
  -X POST http://localhost:3000/oauth/token
```

Then you can use API.

```
curl -H "Accept: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -F 'page=1' \
  -F 'per_page=20' \
  -X GET http://localhost:3000/v1/users
```

## Author

[Tatsuya Miyamae (BitArts, Inc.)](http://bitarts.jp/)

## Licence

The MIT License (MIT)

Copyright (c) 2014 BitArts, Inc. and Tatsuya Miyamae

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
