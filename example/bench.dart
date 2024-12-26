/// Benchmarking.
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
    })
    ..onPlayerMessage((PlayerMessageContext ctx) async {
      if (names.containsValue(ctx.sender)) return;

      final List<DateTime> executions = [];
      final iterations = 10e2;
      for (int i = 1; i <= iterations; i++) {
          await ctx.client.execute('say $i/$iterations', wait: false);
          executions.add(DateTime.now());
      }
      final duration = executions.last.difference(executions.first);
      print('Executed $iterations commands in $duration w/o waiting.');
    });

  // setup logger
  final log = Logger.root;
  log.level = Level.INFO;
  log.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  // launch server
  await server.serve(
    InternetAddress('0.0.0.0'),
    6464,
  );
}
