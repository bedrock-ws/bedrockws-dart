/// A simple echo server.
library;

import 'dart:io';
import 'package:bedrockws/bedrockws.dart';
import 'package:logging/logging.dart';

void main() async {
  // intitialize server
  final server = BedrockServer()
    ..onReady((ReadyContext ctx) async {
      print('Ready @ ${ctx.address.address}:${ctx.port}');
    })
    ..onConnect((ConnectContext ctx) async {
      print('Established connection');
      await ctx.client.execute('say hi');
    })
    ..onPlayerMessage((PlayerMessageContext ctx) async {
      if (ctx.sender == name) return;
      await ctx.client.execute('say ${ctx.message}');
    });

  // setup logger
  final log = Logger.root;
  log.level = Level.ALL;
  log.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  // launch server
  await server.serve(
    InternetAddress('0.0.0.0'),
    6464,
  );
}
