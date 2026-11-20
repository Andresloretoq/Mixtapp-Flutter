import 'package:material_ui/material_ui.dart';

import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import '../widgets/components.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onAlbum});
  final ValueChanged<MusicItem> onAlbum;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  String? category;
  static const genres = [
    ('Rock', 'rock'),
    ('Metal', 'metal'),
    ('Nu metal', 'nu_metal'),
    ('Reggaetón', 'reggaeton'),
    ('Música popular', 'popular_music'),
  ];
  @override
  Widget build(BuildContext context) {
    var results = DemoData.catalog.where((item) {
      final matchesQuery = '${item.title} ${item.artist}'
          .toLowerCase()
          .contains(query.trim().toLowerCase());
      final matchesCategory =
          category == null ||
          !genres.any((g) => g.$1 == category) ||
          item.genre == category;
      return matchesQuery && matchesCategory;
    }).toList();
    if (category == 'Lanzamientos') {
      results.sort((a, b) => b.year.compareTo(a.year));
    }
    return AppBackground(
      tint: AppColors.violet,
      child: Column(
        children: [
          const ScreenHeader('Buscar'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              children: [
                TextField(
                  onChanged: (value) => setState(() => query = value),
                  decoration: const InputDecoration(
                    hintText: 'Álbumes, canciones, artistas…',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 24),
                if (query.trim().isNotEmpty || category != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          category ?? 'Resultados',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      if (category != null)
                        IconButton(
                          tooltip: 'Quitar categoría',
                          onPressed: () => setState(() => category = null),
                          icon: const Icon(Icons.close),
                        ),
                    ],
                  ),
                  if (results.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No encontramos resultados. Prueba con otro nombre.',
                      ),
                    ),
                  ...results.map(
                    (item) => AlbumRow(
                      item,
                      onTap: () => widget.onAlbum(item),
                      trailing: Text(
                        category == 'Lanzamientos' ? '${item.year}' : '★ 4.8',
                        style: const TextStyle(color: AppColors.pink),
                      ),
                    ),
                  ),
                ] else ...[
                  const SectionTitle('Explorar por'),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _criterion(
                        'Lanzamientos',
                        Icons.calendar_month_outlined,
                        AppColors.violet,
                      ),
                      const SizedBox(width: 10),
                      _criterion(
                        'Más populares',
                        Icons.trending_up,
                        const Color(0xFFFF7A6B),
                      ),
                      const SizedBox(width: 10),
                      _criterion(
                        'Mejor calificados',
                        Icons.star_outline,
                        AppColors.magenta,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const SectionTitle('Géneros'),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: genres.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 110,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                    itemBuilder: (context, i) => InkWell(
                      onTap: () => setState(() => category = genres[i].$1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Cover(genres[i].$2, radius: 0),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black87],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14,
                              right: 10,
                              bottom: 10,
                              child: Text(
                                genres[i].$1,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _criterion(String title, IconData icon, Color color) => Expanded(
    child: InkWell(
      onTap: () => setState(() => category = title),
      child: Container(
        height: 112,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [color, AppColors.magenta],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 28, color: Colors.white),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
