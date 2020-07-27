import 'package:counter_app/main.app.framy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  group('FramyWidgetDependenciesPanel', () {
    testWidgets('should build', (WidgetTester tester) async {
      await tester.pumpWidget(FramyAppWrapperWithScaffold(
        FramyWidgetDependenciesPanel(
          dependencies: [],
          presets: {},
        ),
      ));
      expect(find.byKey(Key('FramyWidgetDependenciesPanel')), findsOneWidget);
    });

    testWidgets('should display dependency labels for each dependency',
        (WidgetTester tester) async {
      //given
      final dependencies = [
        FramyDependencyModel<String>('name1', 'String', null),
        FramyDependencyModel<int>('name2', 'int', null),
      ];
      //when
      await tester.pumpWidget(FramyAppWrapperWithScaffold(
        FramyWidgetDependenciesPanel(
          dependencies: dependencies,
          presets: {},
        ),
      ));
      //then
      expect(find.text('name1'), findsOneWidget);
      expect(find.text('name2'), findsOneWidget);
    });

    testWidgets('should change string dependency value when typed in input',
        (WidgetTester tester) async {
      //given
      var model = FramyDependencyModel<String>('name1', 'String', null);
      await tester.pumpWidget(FramyAppWrapperWithScaffold(
        FramyWidgetDependenciesPanel(
          dependencies: [model],
          onChanged: (dep) => model =
              FramyDependencyModel<String>(dep.name, 'String', dep.value),
          presets: {},
        ),
      ));
      //when
      await tester.enterText(
          find.byKey(Key('framy_dependency_name1_input')), 'foo foo');
      //then
      expect(model.name, 'name1');
      expect(model.value, 'foo foo');
    });

    testWidgets(
        'should have tabs with Dependencies and Callbacks names when there is a Function dependency',
        (WidgetTester tester) async {
      //given
      final model =
          FramyDependencyModel<Function()>('onPressed', 'Function()', null);
      //when
      await tester.pumpWidget(FramyAppWrapperWithScaffold(
        FramyWidgetDependenciesPanel(
          dependencies: [model],
          presets: {},
        ),
      ));
      //then
      expect(find.text('Dependencies'), findsOneWidget);
      expect(find.text('Callbacks'), findsOneWidget);
    });

    testWidgets(
        'should not have tabs with Dependencies and Callbacks names when there is no Function dependency',
        (WidgetTester tester) async {
      //given
      final model = FramyDependencyModel<String>('name1', 'String', null);
      //when
      await tester.pumpWidget(FramyAppWrapperWithScaffold(
        FramyWidgetDependenciesPanel(
          dependencies: [model],
          presets: {},
        ),
      ));
      //then
      expect(find.text('Dependencies'), findsNothing);
      expect(find.text('Callbacks'), findsNothing);
    });
  });
}
