import 'dart:io';

import 'package:bedrockws/bedrockws.dart';

sealed class Context {
  /// The server that handled the event that got triggered.
  BedrockServer get server;

  /// The client that handled the event that got triggered.
  Client? get client;

  /// The raw data received by Minecraft.
  dynamic get rawData;
}

/// The context provided when a connection has been established.
class ConnectContext extends Context {
  final BedrockServer _server;
  final Client _client;

  ConnectContext(this._server, this._client);

  @override
  BedrockServer get server => _server;

  @override
  Client get client => _client;

  @override
  dynamic get rawData => {};
}

/// The context provided when a client has disconnected from the server.
class DisconnectContext extends Context {
  final BedrockServer _server;
  final Client _client;

  DisconnectContext(this._server, this._client);

  @override
  BedrockServer get server => _server;

  @override
  Client get client => _client;

  @override
  dynamic get rawData => {};
}

/// The context provided when the server is ready to establish a connection.
class ReadyContext extends Context {
  final BedrockServer _server;
  final InternetAddress _address;
  final int _port;

  ReadyContext(this._server, this._address, this._port);

  @override
  BedrockServer get server => _server;

  @override
  Client? get client => null;

  @override
  dynamic get rawData => {};

  /// The address the server listens on.
  InternetAddress get address => _address;

  /// The port the server listens on.
  int get port => _port;
}

// TODO

class BlockBrokenContext extends Context {
  final BedrockServer _server;
  final Client _client;
  final dynamic _rawData;

  BlockBrokenContext(this._server, this._client, this._rawData);

  @override
  BedrockServer get server => _server;

  @override
  Client get client => _client;

  @override
  dynamic get rawData => _rawData;

  /// The ID of the block that was destroyed.
  String get id => rawData['body']['block']['id'];

  /// The namespace of the block that was destroyed.
  String get namespace => rawData['body']['block']['namespace'];

  /// The amount of block that were destroyed.
  int get count => rawData['body']['count'];

  /// The destruction method that was used to destroy the block.
  int get destructionMethod => rawData['body']['destructionMethod'];

  /// The player that destroyed the block.
  String get playerName => rawData['body']['player']['name'];

  /// The XYZ coordinates representing the location of the player that
  /// destroyed the block.
  (double, double, double) get playerPosition {
    final coords = rawData['body']['player']['position'];
    return (coords['x'], coords['y'], coords['z']);
  }

  /// The ID of the tool that was used to destroy the block.
  String? get tool {
    if (rawData['body'].containsKey('tool')) {
      return rawData['body']['tool']['id'];
    }
    return null;
  }
}

class BlockPlacedContext extends Context {
  final BedrockServer _server;
  final Client _client;
  final dynamic _rawData;

  BlockPlacedContext(this._server, this._client, this._rawData);

  @override
  BedrockServer get server => _server;

  @override
  Client get client => _client;

  @override
  dynamic get rawData => _rawData;

  /// The ID of the block that was placed.
  String get id => rawData['body']['block']['id'];

  /// The namespace of the block that was placed.
  String get namespace => rawData['body']['block']['namespace'];

  /// The amount of block that were placed.
  int get count => rawData['body']['count'];

  /// The player that place the block.
  String get playerName => rawData['body']['player']['name'];

  /// The XYZ coordinates representing the location of the player that placed
  /// the block.
  (double, double, double) get playerPosition {
    final coords = rawData['body']['player']['position'];
    return (coords['x'], coords['y'], coords['z']);
  }

  /// The ID of the tool that was used to place the block.
  String? get tool {
    if (rawData['body'].containsKey('tool')) {
      return rawData['body']['tool']['id'];
    }
    return null;
  }
}

class PlayerMessageContext extends Context {
  final BedrockServer _server;
  final Client _client;
  final dynamic _rawData;

  PlayerMessageContext(this._server, this._client, this._rawData);

  @override
  BedrockServer get server => _server;

  @override
  Client get client => _client;

  @override
  dynamic get rawData => _rawData;

  /// The message that got sent.
  String get message => rawData['body']['message'];

  /// The sender that sent the message.
  String get sender => rawData['body']['sender'];

  /// The type of the message.
  String get type => rawData['body']['type'];
}
