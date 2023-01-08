# example

To get started download the latest binary from [pocketbase](https://pocketbase.io/docs/) and start a local server.

Set the username and password to the following:

```dart
const username = 'test@admin.com';
const password = 'Password123';
```

Start the server and you should be able to open the following url:

```bash
http://127.0.0.1:8090
```

Create a new collection called `todo` and add a field `name` with the type `text`.

Run the example app and you should be able to login with the above credentials.

## Run on Emulator

If you want to run the example app on an Android emulator, you may have to change `127.0.0.1` to `10.0.2.2` in the Pocketbase URL.

## Run on Physical Device

If you want to run the example app on a physical device, connect the device, enable USB debugging and 
enable port forwarding. On Android this can be done by executing
```bash
adb reverse tcp:8000 tcp:8000
```
in the root of this application (make sure the adb script from Android SDK is inside your PATH).
iOS port forwarding: TODO