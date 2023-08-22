# Device Reader

## Installation & Usage

Install gems

```
bundle install
```

Run a server
```
rails s
```


## API Endpoints


Creates a device and readings. Returns newly created device.

`POST http://localhost:3000/devices/`

Return all devices

`GET http://localhost:3000/devices/`

Returns the `cumulative-count` for a given device ID

`GET http://localhost:3000/devices/:id/cumulative-count`

Returns the `latest-timestamp`

`GET http://localhost:3000/devices/:id/latest-timestamp`

---
## Architecture
The Device Reader project is fashioned after a conventional Ruby on Rails setup. This project leverages Ruby on Rails version 7.

The majority of the logic for this current iteration lies within the `/model` and `/controller` directories. There are a couple custom route declarations that can be found in `/config/routes.rb`
## Next Steps
The next iteration of Device Reader would ideally see the following:
- a robust testing layer
- abstraction of logic out of the `devices controller` and moved into a `concern` layer or a `services` layer with something akin to a `DeviceReaderService`
- Additional considerations would be data persistence and abstraction of existing error handling.
- Observability would aid in monitoring reliability
- A horizontal scaling approach would aid in availability of the service.
