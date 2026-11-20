# Mixtapp · Flutter

Adaptación de seis pantallas de la aplicación Android Mixtapp a Flutter y Material 3.
La referencia es [AndresContreras1/Mixtapp](https://github.com/AndresContreras1/Mixtapp),
commit `d20ad7b` (rediseño visual), consultado el 19 de noviembre de 2026.

## Pantallas

| Pantalla | Implementación | Referencia Android |
| --- | --- | --- |
| Inicio | `lib/screens/home_screen.dart` | `ui/screens/home/HomeScreen.kt` |
| Buscar | `lib/screens/search_screen.dart` | `ui/screens/search/SearchScreen.kt` |
| Detalle de álbum | `lib/screens/detail_screen.dart` | `ui/screens/detail/DetailScreen.kt` |
| Escribir reseña | `lib/screens/review_screen.dart` | `ui/screens/review/WriteReviewScreen.kt` |
| Perfil | `lib/screens/profile_screen.dart` | `ui/screens/profile/ProfileScreen.kt` |
| Iniciar sesión | `lib/screens/login_screen.dart` | `ui/screens/login/LoginScreen.kt` |

Se conservan la paleta ciruela y rosada, Outfit, las portadas, tarjetas, campos y jerarquía del
rediseño Android. El selector **Pantalla**, arriba, permite revisar las seis vistas. También
funcionan los accesos principales entre Inicio, Buscar, Detalle, Reseña y Perfil.

## Ejecutar

Instala Flutter 3.47 o superior con Dart 3.13 o superior y configura el Android SDK desde Android Studio.
Abre esta carpeta como proyecto Flutter con los plugins Flutter y Dart instalados.

```bash
flutter pub get
flutter run
```

Para abrir una pantalla directamente:

```bash
flutter run --dart-define=SCREEN=profile
```

Valores admitidos: `home`, `search`, `detail`, `review`, `profile`, `login`.
Para navegador: `flutter run -d chrome`. Para generar Android: `flutter build apk --debug`.

## Datos e interacciones

Los modelos y el catálogo de ejemplo están en `lib/data/demo_data.dart`. Las portadas y
la fuente están incluidas en `assets/`, así las seis pantallas funcionan sin Firebase.
Los filtros, búsqueda, estrellas, contraseña visible, selección de fecha, favoritos,
guardados y pestañas de perfil responden con estado local.

En el acceso de demostración se acepta cualquier correo con formato válido y una contraseña
de al menos seis caracteres. Publicar valida el formulario y muestra una confirmación local.
La ubicación de ejemplo es Bogotá. Los cambios se reinician al salir de cada pantalla.
Las acciones de audio y los enlaces sociales muestran mensajes de demostración.

## Organización

- `lib/screens/` contiene las seis vistas.
- `lib/widgets/components.dart` reúne tarjetas, imágenes, filtros y componentes compartidos.
- `lib/theme/app_theme.dart` adapta los colores y tipografía del tema Android.
- `lib/data/demo_data.dart` contiene los modelos y datos de ejemplo.

## Verificación

```bash
flutter analyze
flutter test
flutter build apk --debug
```

Las pruebas comprueban las seis pantallas a 360 px, el formulario de acceso y el recorrido
Buscar → Detalle → Escribir reseña.

## Recursos

Outfit procede de Google Fonts y conserva su licencia en `assets/fonts/OFL.txt`.
Las portadas proceden de las mismas URLs de Deezer utilizadas en `LocalPreviewProvider.kt`
y `LocalSearchCategoriesProvider.kt` de Android. Se incluyen para esta demostración académica.
La autoría de las portadas corresponde a sus respectivos titulares.
