## GET /v1/users/:user_id
Returns user resource.

### Example

#### Request
```
GET /v1/users/718075440 HTTP/1.1
Accept: application/json
Authorization: Bearer 6756016c71cc65a92788eea25d7eaadf429dc5fb353bfe6e776de3c221ef0a21
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: no-cache
Content-Length: 205
Content-Type: application/json; charset=utf-8
P3P: CP='UNI CUR OUR'
Set-Cookie: _session_id=1fc93964fc1b604f20a4cf35647c1f32; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 32031ccc-d7b2-41eb-ab02-7a8542339e98
X-Runtime: 0.080115
X-XSS-Protection: 1; mode=block

{
  "id": 718075440,
  "key": "alice",
  "name": "alice",
  "nick_name": "",
  "email": "alice@example.com",
  "password": null,
  "bio": null,
  "created_at": "2014-11-24T16:36:06.863+09:00",
  "updated_at": "2014-11-24T16:36:06.863+09:00"
}
```

## PUT /v1/users/:user_id
Updates user resource.

### Example

#### Request
```
PUT /v1/users/718075440 HTTP/1.1
Accept: application/json
Authorization: Bearer 85e531c1378e9e6ed8c1839562a7c8c29cfa8fb9907e9543803898692a4a6533
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
_session_id=6146df76ef48ce5eb4339a5398a67294; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 915abb6c-a279-4af8-808c-02262d22e95a
X-Runtime: 0.012551
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
Authorization: Bearer 605719cf791c7ceb2f2c780d6926676dfe23211b031dc9b6ff0c47a0f77ec896
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: no-cache
Content-Length: 1722
Content-Type: application/json; charset=utf-8
P3P: CP='UNI CUR OUR'
Set-Cookie: _session_id=1914190f3822915a6bca9286457b01cd; path=/; HttpOnly
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-List-TotalCount: 8
X-Request-Id: 04e48cb3-5b46-4765-aa7a-972982453401
X-Runtime: 0.015258
X-XSS-Protection: 1; mode=block

[
  {
    "id": 718075443,
    "key": "factory-user7",
    "name": "factory-user7",
    "nick_name": "",
    "email": "factory-user7@example.com",
    "password": null,
    "bio": null,
    "created_at": "2014-11-24T16:36:07.071+09:00",
    "updated_at": "2014-11-24T16:36:07.071+09:00"
  },
  {
    "id": 718075442,
    "key": "factory-user6",
    "name": "factory-user6",
    "nick_name": "",
    "email": "factory-user6@example.com",
    "password": null,
    "bio": null,
    "created_at": "2014-11-24T16:36:07.068+09:00",
    "updated_at": "2014-11-24T16:36:07.068+09:00"
  },
  {
    "id": 718075441,
    "key": "factory-user5",
    "name": "factory-user5",
    "nick_name": "",
    "email": "factory-user5@example.com",
    "password": null,
    "bio": null,
    "created_at": "2014-11-24T16:36:07.062+09:00",
    "updated_at": "2014-11-24T16:36:07.062+09:00"
  },
  {
    "id": 718075440,
    "key": "factory-user4",
    "name": "factory-user4",
    "nick_name": "",
    "email": "factory-user4@example.com",
    "password": null,
    "bio": null,
    "created_at": "2014-11-24T16:36:07.057+09:00",
    "updated_at": "2014-11-24T16:36:07.057+09:00"
  },
  {
    "id": 718075439,
    "key": "ua001",
    "name": "",
    "nick_name": "",
    "email": "admin@example.com",
    "password": null,
    "bio": null,
    "created_at": "2014-11-24T16:36:06.000+09:00",
    "updated_at": "2014-11-24T16:36:06.000+09:00"
  },
  {
    "id": 576709754,
    "key": "u003",
    "name": "",
    "nick_name": "",
    "email": "user3@example.com",
    "password": null,
    "bio": null,
    "created_at": "2014-11-24T16:36:06.000+09:00",
    "updated_at": "2014-11-24T16:36:06.000+09:00"
  },
  {
    "id": 358143215,
    "key": "u002",
    "name": "",
    "nick_name": "",
    "email": "user2@example.com",
    "password": null,
    "bio": null,
    "created_at": "2014-11-24T16:36:06.000+09:00",
    "updated_at": "2014-11-24T16:36:06.000+09:00"
  },
  {
    "id": 206669143,
    "key": "u001",
    "name": "",
    "nick_name": "",
    "email": "user1@example.com",
    "password": null,
    "bio": null,
    "created_at": "2014-11-24T16:36:06.000+09:00",
    "updated_at": "2014-11-24T16:36:06.000+09:00"
  }
]
```
