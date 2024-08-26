/// A response sent by the client.
class CommandResponse {
  final String _message;
  final int _status;

  CommandResponse(this._message, this._status);

  /// The message of the response.
  String get message => _message;

  /// The status of the reponse.
  int get status => _status;

  /// Whether the command has been executed successfully.
  bool get ok => _status == 0;

  // TODO: method that throws on failure
}
