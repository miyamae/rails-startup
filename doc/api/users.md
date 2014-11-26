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
Authorization: Bearer 4d696d87ccefe1823408e1a6fc47e9c7c851f8c841d704df53782e64b8332c73
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: no-cache
Content-Length: 1594
Content-Type: application/json; charset=utf-8
P3P: CP='UNI CUR OUR'
Set-Cookie: _session_id=edd2495778834bcdc113fc15fa7f925d; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-List-TotalCount: 8
X-Request-Id: 691d99ba-3894-40bf-941b-b565cb0ba318
X-Runtime: 0.107333
X-XSS-Protection: 1; mode=block

[
  {
    "id": 718075443,
    "key": "factory-user4",
    "name": "factory-user4",
    "nick_name": "",
    "email": "factory-user4@example.com",
    "bio": null,
    "created_at": "2014-11-27T01:41:35.850+09:00",
    "updated_at": "2014-11-27T01:41:35.850+09:00"
  },
  {
    "id": 718075442,
    "key": "factory-user3",
    "name": "factory-user3",
    "nick_name": "",
    "email": "factory-user3@example.com",
    "bio": null,
    "created_at": "2014-11-27T01:41:35.846+09:00",
    "updated_at": "2014-11-27T01:41:35.846+09:00"
  },
  {
    "id": 718075441,
    "key": "factory-user2",
    "name": "factory-user2",
    "nick_name": "",
    "email": "factory-user2@example.com",
    "bio": null,
    "created_at": "2014-11-27T01:41:35.841+09:00",
    "updated_at": "2014-11-27T01:41:35.841+09:00"
  },
  {
    "id": 718075440,
    "key": "factory-user1",
    "name": "factory-user1",
    "nick_name": "",
    "email": "factory-user1@example.com",
    "bio": null,
    "created_at": "2014-11-27T01:41:35.837+09:00",
    "updated_at": "2014-11-27T01:41:35.837+09:00"
  },
  {
    "id": 718075439,
    "key": "ua001",
    "name": "",
    "nick_name": "",
    "email": "admin@example.com",
    "bio": null,
    "created_at": "2014-11-27T01:41:35.000+09:00",
    "updated_at": "2014-11-27T01:41:35.000+09:00"
  },
  {
    "id": 576709754,
    "key": "u003",
    "name": "",
    "nick_name": "",
    "email": "user3@example.com",
    "bio": null,
    "created_at": "2014-11-27T01:41:35.000+09:00",
    "updated_at": "2014-11-27T01:41:35.000+09:00"
  },
  {
    "id": 358143215,
    "key": "u002",
    "name": "",
    "nick_name": "",
    "email": "user2@example.com",
    "bio": null,
    "created_at": "2014-11-27T01:41:35.000+09:00",
    "updated_at": "2014-11-27T01:41:35.000+09:00"
  },
  {
    "id": 206669143,
    "key": "u001",
    "name": "",
    "nick_name": "",
    "email": "user1@example.com",
    "bio": null,
    "created_at": "2014-11-27T01:41:35.000+09:00",
    "updated_at": "2014-11-27T01:41:35.000+09:00"
  }
]
```

## PUT /v1/users/:user_id
Updates user resource.

### Example

#### Request
```
PUT /v1/users/718075440 HTTP/1.1
Accept: application/json
Authorization: Bearer 65dfd824bb3909038a70a6f9b998e735bad0dbcde93ebe2be27a4371f2100342
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
_session_id=a5cab017ca5d7eceeb1623d1785c8d91; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 2d104855-99fb-473c-832f-18f6ccfe0825
X-Runtime: 0.014738
X-XSS-Protection: 1; mode=block
```

## GET /v1/users/:user_id
Returns user resource.

### Example

#### Request
```
GET /v1/users/718075440 HTTP/1.1
Accept: application/json
Authorization: Bearer e51eaa677910e05ec64699de48883b3c39e90afe269ade6e885c1b4b5e08d206
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: no-cache
Content-Length: 189
Content-Type: application/json; charset=utf-8
P3P: CP='UNI CUR OUR'
Set-Cookie: _session_id=9bfc1dc3178241eb4191139cf1615df3; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 63e98527-99bb-4b7b-b897-58020e8baf9c
X-Runtime: 0.014362
X-XSS-Protection: 1; mode=block

{
  "id": 718075440,
  "key": "alice",
  "name": "alice",
  "nick_name": "",
  "email": "alice@example.com",
  "bio": null,
  "created_at": "2014-11-27T01:41:36.078+09:00",
  "updated_at": "2014-11-27T01:41:36.078+09:00"
}
```
