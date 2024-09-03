import 'package:bedrockws/bedrockws.dart';
import 'package:test/test.dart';

void main() {
  test('Rawtext with all components without variables', () {
    final rawtext = Rawtext(
      [
        Text('Hello '),
        Text('World and Hello '),
        Selector('@p'),
        Score(name: '@p', objective: 'money'),
        Translate('multiplayer.player.joined'),
      ],
    );
    expect(
      rawtext.toString(),
      equals(
        '{"rawtext":['
        '{"text":"Hello "},'
        '{"text":"World and Hello "},'
        '{"selector":"@p"},'
        '{"score":{"name":"@p","objective":"money"}},'
        '{"translate":"multiplayer.player.joined"}'
        ']}',
      ),
    );
  });
}
