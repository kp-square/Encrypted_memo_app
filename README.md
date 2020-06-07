# Encrypted_memo_app

This is an upgraded form of the legendary memo app of android being build using dart/flutter. Similar in looks and feel.
It uses flutter-hive https://pub.dev/packages/hive database as an offline database to store notes.
Notes can be password protected if necessary. There is option to apply data encryption.

It uses PBKDF2 for key generation with sha256 as message digest.

Key is stored in keystore in android and keychain in ios.

This app is under development. Will soon be available in android play store.
