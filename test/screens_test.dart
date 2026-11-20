import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mixtapp_flutter/main.dart';

void main() {
  testWidgets(
    'Las seis pantallas caben en un teléfono pequeño y permiten escribir',
    (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MixtappApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (final screen in DemoScreen.values) {
        await tester.tap(find.byKey(const Key('screenSelector')));
        await tester.pumpAndSettle();
        await tester.tap(find.text(screen.label).last);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: screen.label);
      }
      await tester.enterText(
        find.byKey(const Key('email')),
        'demo@mixtapp.test',
      );
      await tester.enterText(find.byKey(const Key('password')), 'demo123');
      await tester.ensureVisible(find.text('Ingresar'));
      await tester.tap(find.text('Ingresar'));
      await tester.pumpAndSettle();
      expect(find.text('En tendencia'), findsOneWidget);
    },
  );

  testWidgets('Una búsqueda muestra el álbum y permite abrir su reseña', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MixtappApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.search).last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'From Zero');
    await tester.pumpAndSettle();
    await tester.tap(find.text('From Zero'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Escribir reseña'),
      250,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Escribir reseña'));
    await tester.pumpAndSettle();
    expect(find.text('Tu calificación'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
