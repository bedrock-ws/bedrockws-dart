import 'package:bedrockws/bedrockws.dart' as bws;
import 'package:test/test.dart';

void main() {
  test('Icon', () {
    expect(bws.CodeBuilderButton().toString(), equals('\ue103'));
  });

  test('TextSpan', () {
    final text = bws.TextSpan(
      text: 'Hello ',
      style: bws.TextStyle(italic: true),
      children: [
        bws.TextSpan(
          text: 'beautiful',
          style: bws.TextStyle(color: bws.Green(), bold: true),
        ),
        bws.TextSpan(text: ' World'),
      ],
    );
    expect(text.toString(), equals('§oHello §a§lbeautiful§r World§r'));
  });
}
