## PUT /v1/users/:user_id
Updates user resource.

### Example

#### Request
```
PUT /v1/users/2 HTTP/1.1
Accept: application/json
Authorization: Bearer 2791fe67a3e9b20759b6c75c6e3ab52aaf7409a7222d5f1e80c30856f85f6163
Content-Length: 8
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

name=bob
```

#### Response
```
HTTP/1.1 204
Cache-Control: no-cache
P3P: CP='UNI CUR OUR'
Set-Cookie: request_method=PUT; path=/
_session_id=0235ef4e85f11804c025c870061b60bc; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 65ee9fd9-eab8-4107-9dd1-0e2b2439f59d
X-Runtime: 0.046961
X-XSS-Protection: 1; mode=block
```

## GET /v1/users
Returns user resources.

### Parameters
* `page` integer - Parameter for pagination.
* `per_page` integer - Parameter for pagination.

### Example

#### Request
```
GET /v1/users HTTP/1.1
Accept: application/json
Authorization: Bearer 1e16bb7d4f0aa1352c5da8cfece3205cc9f82cccabaf881a4e9a5e55e7003ea2
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: no-cache
Content-Length: 1259
Content-Type: application/json; charset=utf-8
P3P: CP='UNI CUR OUR'
Set-Cookie: _session_id=1a435ed85a3d932f912a9c8e4af40558; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-List-TotalCount: 5
X-Request-Id: e7a06620-934b-4fd0-bce6-c0346c731133
X-Runtime: 0.015661
X-XSS-Protection: 1; mode=block

[
  {
    "id": 5,
    "key": "dcDJWHk1",
    "name": "user6",
    "nick_name": "",
    "email": "user6@example.com",
    "bio": null,
    "created_at": "2014-12-10T02:26:55.295+09:00",
    "updated_at": "2014-12-10T02:26:55.295+09:00",
    "_links": {
      "self": {
        "href": "http://rails-startup.dev/v1/users/5"
      }
    }
  },
  {
    "id": 4,
    "key": "R5AS3EIo",
    "name": "user5",
    "nick_name": "",
    "email": "user5@example.com",
    "bio": null,
    "created_at": "2014-12-10T02:26:55.291+09:00",
    "updated_at": "2014-12-10T02:26:55.291+09:00",
    "_links": {
      "self": {
        "href": "http://rails-startup.dev/v1/users/4"
      }
    }
  },
  {
    "id": 3,
    "key": "FLUatLC5",
    "name": "user4",
    "nick_name": "",
    "email": "user4@example.com",
    "bio": null,
    "created_at": "2014-12-10T02:26:55.286+09:00",
    "updated_at": "2014-12-10T02:26:55.286+09:00",
    "_links": {
      "self": {
        "href": "http://rails-startup.dev/v1/users/3"
      }
    }
  },
  {
    "id": 2,
    "key": "e2EZuVkY",
    "name": "user3",
    "nick_name": "",
    "email": "user3@example.com",
    "bio": null,
    "created_at": "2014-12-10T02:26:55.278+09:00",
    "updated_at": "2014-12-10T02:26:55.278+09:00",
    "_links": {
      "self": {
        "href": "http://rails-startup.dev/v1/users/2"
      }
    }
  },
  {
    "id": 1,
    "key": "mW5xs7ml",
    "name": "",
    "nick_name": "Administrator",
    "email": "admin@example.com",
    "bio": null,
    "created_at": "2014-12-05T02:41:35.017+09:00",
    "updated_at": "2014-12-05T02:41:35.024+09:00",
    "_links": {
      "self": {
        "href": "http://rails-startup.dev/v1/users/1"
      }
    }
  }
]
```

## GET /v1/users/:user_id
Returns user resource.

### Example

#### Request
```
GET /v1/users/2 HTTP/1.1
Accept: application/json
Authorization: Bearer f9093e7e91b49a3d547e0098fcd26a1e3162c5fd99e6948f8df13a2e60ddb279
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: no-cache
Content-Length: 249
Content-Type: application/json; charset=utf-8
P3P: CP='UNI CUR OUR'
Set-Cookie: _session_id=5e0d1077904df3420cf3a30cb9220562; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 68f28184-b35e-4604-87eb-406a6c007987
X-Runtime: 0.011562
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "key": "6Fnmmh3G",
  "name": "alice",
  "nick_name": "",
  "email": "alice@example.com",
  "bio": null,
  "created_at": "2014-12-10T02:26:55.328+09:00",
  "updated_at": "2014-12-10T02:26:55.328+09:00",
  "_links": {
    "self": {
      "href": "http://rails-startup.dev/v1/users/2"
    }
  }
}
```
