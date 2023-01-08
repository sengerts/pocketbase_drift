# PocketBase Drift

[PocketBase](https://pub.dev/packages/pocketbase) client cached with [Drift](https://pub.dev/packages/drift).

- Full Text Search
- Offline first
- Partial updates
- CRUD support
- SQLite storage
- All platforms supported
- [Example app](/example/)
- Tests

## Compatibility

This plugin is currently compatible with Pocketbase v0.11.0 and pocketbase (dart plugin) v0.6.0.

## Getting Started

Replace a pocketbase client with a drift client.

```diff
- import 'package:pocketbase/pocketbase.dart';
+ import 'package:pocketbase_drift/pocketbase_drift.dart';

- final client = PocketBase(
+ final client = PocketBaseDrift(
    'http://127.0.0.1:8090'
);
```

## Run Tests

To run the tests inside ./test/pocketbase_drift_store_test.dart:
1. follow the [instructions](./test/pocketbase_drift_store_test.dart) for configuring the `sqlite3` binaries
2. follow the instructions in `./example/README.md` for setting up and starting Pocketbase
3. restart your IDE and then run the tests

## Web

For web, you need to follow the instructions for [Drift](https://drift.simonbinder.eu/web/#drift-wasm) to copy the [sqlite wasm](https://github.com/simolus3/sqlite3.dart/releases) binary into the `web/` directory.
