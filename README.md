# chgk_rating

<!--TODO Add coverage, pub, platform badges-->
![example workflow](https://github.com/vmpay/chgk_rating_dart/actions/workflows/main.yml/badge.svg)
[![Pub](https://img.shields.io/pub/v/chgk_rating.svg)](https://pub.dartlang.org/packages/chgk_rating)

Dart wrapper client for the competitive What? Where? When? rating [WebAPIRating](https://rating.chgk.info/api-doc)

## Getting Started

### Add dependency

Add to your pubspec.yaml the latest version of the library

```yaml
dependencies:
  chgk_rating: ^<latest_version>
```

<!-- TOTO pass the example -->
### Fetch player's data example

Create instance of ChgkRating class

```dart
ChgkRating chgkRating = ChgkRating();
``` 

Search for the player by name and surname
```dart
PlayerSearch playerSearch = await chgkRating.getPlayerBy(name: 'player_name', surname: 'player_surname');
```

## Copyright & License 
This project follows Apache 2.0 [license](https://github.com/vmpay/chgk_rating_dart/blob/master/LICENSE)

## Features and bugs 
Please file feature requests and bugs at the [issue tracker](https://github.com/vmpay/chgk_rating_dart/issues).

