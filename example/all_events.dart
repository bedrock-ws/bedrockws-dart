/// An example that logs info about every event it receives.
library;

import 'dart:io';
import 'package:bedrockws/bedrockws.dart';

void main() async {
  // intitialize server
  final server = BedrockServer()
    ..onReady((ReadyContext ctx) async {
      print('Ready');
      print('address = ${ctx.address}');
      print('port = ${ctx.port}');
    })
    ..onConnect((ConnectContext ctx) async {
      print('Connect');
    })
    ..onDisconnect((DisconnectContext ctx) async {
      print('Disconnect');
    })
    ..onBlockBroken((BlockBrokenContext ctx) async {
      print('BlockBroken');
      print('id = ${ctx.id}');
      print('namespace = ${ctx.namespace}');
      print('count = ${ctx.count}');
      print('destructionMethod = ${ctx.destructionMethod}');
      print('playerName = ${ctx.playerName}');
      print('playerPosition = ${ctx.playerPosition}');
      print('tool = ${ctx.tool}');
    })
    ..onBlockPlaced((BlockPlacedContext ctx) async {
      print('BlockBroken');
      print('id = ${ctx.id}');
      print('namespace = ${ctx.namespace}');
      print('count = ${ctx.count}');
      print('playerName = ${ctx.playerName}');
      print('playerPosition = ${ctx.playerPosition}');
      print('tool = ${ctx.tool}');
    })
    ..onPlayerMessage((PlayerMessageContext ctx) async {
      print('PlayerMessage');
      print('message = ${ctx.message}');
      print('sender = ${ctx.sender}');
      print('type = ${ctx.type}');
    });

  // setup logger
  //final log = Logger.root;
  //log.level = Level.ALL;
  //log.onRecord.listen((record) {
  //  print('${record.level.name}: ${record.time}: ${record.message}');
  //});

  // launch server
  await server.serve(
    InternetAddress('0.0.0.0'),
    6464,
  );
}
