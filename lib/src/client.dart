import 'package:async_locks/async_locks.dart' as locks;
import 'package:bedrockws/bedrockws.dart';
import 'package:web_socket_channel/io.dart';
import 'package:logging/logging.dart';
import 'consts.dart' as consts;
import 'package:uuid/v4.dart';
import 'dart:convert';

class Client {
  final _log = Logger('Client');
  final BedrockServer _server;
  final IOWebSocketChannel _channel;
  final List<CommandRequest> _requests = [];
  final locks.BoundedSemaphore _commandProcessingSemaphore =
      locks.BoundedSemaphore(consts.maxCommandProcessing);

  Client(this._server, this._channel);

  BedrockServer get server => _server;

  IOWebSocketChannel get channel => _channel;

  List<CommandRequest> get requests => _requests;

  locks.BoundedSemaphore get commandProcessingSemaphore =>
      _commandProcessingSemaphore;

  Future<CommandResponse?> _send(
      {required Map<String, dynamic> header,
      required Map<String, dynamic> body,
      bool wait = true}) async {
    final identifier = UuidV4();

    header.addAll({'version': 1, 'requestId': identifier.toString()});

    final data = {
      'header': header,
      'body': body,
    };

    final req = CommandRequest(identifier, data);
    await _commandProcessingSemaphore.acquire();
    _log.fine('Sending $data');
    channel.sink.add(jsonEncode(data));
    _requests.add(req);
    if (wait) {
      _log.fine('Waiting for response');
      final res = await req.response;
      _log.fine('Got response');
      return res;
    }
    return null;
  }

  Future<CommandResponse?> execute(String command,
      {String version = consts.minecraftVersion, bool wait = false}) async {
    if (command.startsWith(consts.commandPrefix)) {
      command = command.replaceRange(0, consts.commandPrefix.length, '');
    }
    return await _send(
      header: {
        'messageType': 'commandRequest',
        'messagePurpose': 'commandRequest'
      },
      body: {
        'version': version,
        'commandLine': command,
        'origin': {'type': 'player'},
      },
      wait: wait,
    );
  }

  Future<CommandResponse> subscribe(Event event) async {
    _log.fine('Subscribing to $event');
    return (await _send(
      header: {'messageType': 'commandRequest', 'messagePurpose': 'subscribe'},
      body: {'eventName': event.toString()},
    ))!;
  }

  Future<CommandResponse> unsubscribe(Event event) async {
    _log.fine('Unsubscribing from $event');
    return (await _send(
      header: {
        'messageType': 'commandRequest',
        'messagePurpose': 'unsubscribe'
      },
      body: {'eventName': event.toString()},
      wait: true,
    ))!;
  }
}
