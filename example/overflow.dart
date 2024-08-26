/// An example to stress test the server with commands.
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
      ctx.client.execute('say hi');
    })
    ..onPlayerMessage((PlayerMessageContext ctx) async {
      print(ctx.sender);
      if (ctx.sender == name) return;
      for (int i = 0; i <= 300; i++) {
        ctx.client.execute('say $i');
      }
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
