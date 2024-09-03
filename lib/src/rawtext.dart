import 'dart:convert';

sealed class Component {}

class Text implements Component {
  final String text;

  Text(this.text);
}

class Selector implements Component {
  final String selector;

  Selector(this.selector);
}

class Score implements Component {
  final String name;
  final String objective;

  Score({required this.name, required this.objective});
}

class Translate implements Component {
  final String translation;

  Translate(this.translation);
}

class Rawtext {
  final List<Component> components;
  // TODO: variables may be rawtext components as well; see also https://wiki.bedrock.dev/concepts/rawtext.html#ordering-with
  final List<String> variables;

  Rawtext(this.components, {this.variables = const []});

  @override
  String toString() {
    List<Map<String, dynamic>> result = [];
    for (final component in components) {
      switch (component) {
        case Text():
          result.add({'text': component.text});
        case Selector():
          result.add({'selector': component.selector});
        case Score():
          result.add({
            'score': {'name': component.name, 'objective': component.objective}
          });
        case Translate():
          result.add({'translate': component.translation});
      }
    }
    if (variables.isNotEmpty) {
      result.add({'with': variables});
    }
    return jsonEncode({'rawtext': result});
  }
}
