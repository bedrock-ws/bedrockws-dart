import 'dart:async';
import 'package:bedrockws/bedrockws.dart';
import 'package:uuid/v4.dart';

class CommandRequest {
  final UuidV4 _identifier;
  final dynamic _data;
  final Completer<CommandResponse> _response = Completer();

  CommandRequest(this._identifier, this._data);

  /// The UUID associated to the request.
  UuidV4 get identifier => _identifier;

  /// The data of the request.
  dynamic get data => _data;

  Future<CommandResponse> get response => _response.future;

  Completer<CommandResponse> get rawResponse => _response;
}
