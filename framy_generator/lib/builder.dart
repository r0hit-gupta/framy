import 'package:build/build.dart';
import 'package:framy_generator/framy_generator.dart';
import 'package:framy_generator/json_builder.dart';
import 'package:framy_generator/json_formatter.dart';
import 'package:framy_generator/resolvers/theme_resolver.dart';
import 'package:framy_generator/resolvers/widget_resolver.dart';
import 'package:source_gen/source_gen.dart';

Builder themeBuilder(BuilderOptions options) {
  return JsonLibraryBuilder(
    ThemeResolver(),
    formatOutput: fixJson,
    generatedExtension: '.theme.framy.json',
    header: '',
  );
}

Builder widgetBuilder(BuilderOptions options) {
  return JsonLibraryBuilder(
    WidgetResolver(),
    formatOutput: fixJson,
    generatedExtension: '.widget.framy.json',
    header: '',
  );
}

Builder framyAppBuilder(BuilderOptions options) {
  return LibraryBuilder(
    FramyGenerator(),
    generatedExtension: '.app.framy.dart',
  );
}
