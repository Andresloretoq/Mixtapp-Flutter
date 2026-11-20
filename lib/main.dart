import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'data/demo_data.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/review_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const MixtappApp());
}

class MixtappApp extends StatelessWidget {
  const MixtappApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Mixtapp',
    debugShowCheckedModeBanner: false,
    theme: buildTheme(),
    locale: const Locale('es'),
    supportedLocales: const [Locale('es')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: const ScreenGallery(),
  );
}

enum DemoScreen {
  home('Inicio'),
  search('Buscar'),
  detail('Detalle de álbum'),
  review('Escribir reseña'),
  profile('Perfil'),
  login('Iniciar sesión');

  const DemoScreen(this.label);
  final String label;
}

class ScreenGallery extends StatefulWidget {
  const ScreenGallery({super.key});
  @override
  State<ScreenGallery> createState() => _ScreenGalleryState();
}

class _ScreenGalleryState extends State<ScreenGallery> {
  DemoScreen screen = DemoScreen.values.firstWhere(
    (screen) =>
        screen.name ==
        const String.fromEnvironment('SCREEN', defaultValue: 'home'),
    orElse: () => DemoScreen.home,
  );
  MusicItem selectedItem = DemoData.fromZero;
  void select(DemoScreen next) => setState(() => screen = next);
  void album(MusicItem item) => setState(() {
    selectedItem = item;
    screen = DemoScreen.detail;
  });
  @override
  Widget build(BuildContext context) {
    final body = switch (screen) {
      DemoScreen.home => HomeScreen(onAlbum: album),
      DemoScreen.search => SearchScreen(onAlbum: album),
      DemoScreen.detail => DetailScreen(
        key: ValueKey(selectedItem.title),
        item: selectedItem,
        onReview: () => select(DemoScreen.review),
        onBack: () => select(DemoScreen.home),
      ),
      DemoScreen.review => WriteReviewScreen(
        key: ValueKey(selectedItem.title),
        item: selectedItem,
        onBack: () => select(DemoScreen.detail),
      ),
      DemoScreen.profile => ProfileScreen(
        onAlbum: album,
        onLogin: () => select(DemoScreen.login),
      ),
      DemoScreen.login => LoginScreen(onLogin: () => select(DemoScreen.home)),
    };
    final showBottom = [
      DemoScreen.home,
      DemoScreen.search,
      DemoScreen.profile,
    ].contains(screen);
    return Scaffold(
      backgroundColor: AppColors.bar,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                Container(
                  color: AppColors.bar,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.dashboard_outlined,
                        size: 16,
                        color: AppColors.muted,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Pantalla',
                        style: TextStyle(fontSize: 12, color: AppColors.muted),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<DemoScreen>(
                            key: const Key('screenSelector'),
                            value: screen,
                            isExpanded: true,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              color: AppColors.text,
                              fontSize: 13,
                            ),
                            items: DemoScreen.values
                                .map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value.label),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) select(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(child: body),
                      if (showBottom)
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingActionButton(
                            tooltip: 'Escribir reseña',
                            onPressed: () => select(DemoScreen.review),
                            child: const Icon(Icons.add),
                          ),
                        ),
                    ],
                  ),
                ),
                if (showBottom)
                  NavigationBar(
                    backgroundColor: AppColors.bar,
                    height: 76,
                    selectedIndex: screen == DemoScreen.home
                        ? 0
                        : screen == DemoScreen.search
                        ? 1
                        : 2,
                    onDestinationSelected: (index) => select(
                      [
                        DemoScreen.home,
                        DemoScreen.search,
                        DemoScreen.profile,
                      ][index],
                    ),
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: 'Inicio',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.search),
                        label: 'Buscar',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: 'Perfil',
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
