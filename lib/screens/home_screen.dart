import 'package:material_ui/material_ui.dart';

import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import '../widgets/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onAlbum});
  final ValueChanged<MusicItem> onAlbum;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String filter = 'Para ti';
  @override
  Widget build(BuildContext context) {
    final albums = filter == 'Favoritos'
        ? [DemoData.fromZero, DemoData.master]
        : DemoData.catalog;
    return AppBackground(
      child: Column(
        children: [
          ScreenHeader(
            'Mixtapp',
            actions: [
              IconButton(
                tooltip: 'Siguiendo',
                icon: const Icon(Icons.people_outline),
                onPressed: () => showFeedback(
                  context,
                  'Sigues a Diego, Valentina y 22 personas más.',
                ),
              ),
              IconButton(
                tooltip: 'Notificaciones',
                icon: const Icon(Icons.notifications_none),
                onPressed: () => showFeedback(
                  context,
                  'A Diego le gustó tu reseña de From Zero.',
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              children: [
                FilterRow(
                  labels: const ['Para ti', 'Tendencias', 'Favoritos'],
                  selected: filter,
                  onSelected: (value) => setState(() => filter = value),
                ),
                const SizedBox(height: 24),
                if (filter != 'Favoritos') ...[
                  const SectionTitle('En tendencia'),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () => widget.onAlbum(DemoData.fromZero),
                    borderRadius: BorderRadius.circular(28),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: SizedBox(
                        height: 220,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            const Cover('from_zero', radius: 0),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Color(0xDD000000),
                                  ],
                                  stops: [.25, 1],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 14,
                              left: 14,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.trending_up,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Tendencia en Nu metal',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 18,
                              left: 18,
                              right: 16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'From Zero',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(color: Colors.white),
                                        ),
                                        const Text(
                                          'Linkin Park',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const Text(
                                          '#12 en Nu metal',
                                          style: TextStyle(
                                            color: AppColors.pink,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton.filled(
                                    tooltip: 'Vista previa del álbum',
                                    onPressed: () => showFeedback(
                                      context,
                                      'Vista previa de From Zero · demostración visual',
                                    ),
                                    icon: const Icon(
                                      Icons.play_arrow_rounded,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const SectionTitle('Lo que dicen tus seguidos'),
                  const SizedBox(height: 12),
                  ReviewCard(DemoData.reviews.first),
                  const SizedBox(height: 28),
                ],
                SectionTitle(
                  filter == 'Favoritos'
                      ? 'Tus favoritos'
                      : 'Álbumes para descubrir',
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 208,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: albums.length,
                    separatorBuilder: (_, index) => const SizedBox(width: 14),
                    itemBuilder: (context, i) => SizedBox(
                      width: 140,
                      child: InkWell(
                        onTap: () => widget.onAlbum(albums[i]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Cover(albums[i].image, size: 140, radius: 20),
                            const SizedBox(height: 8),
                            Text(
                              albums[i].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              albums[i].artist,
                              maxLines: 1,
                              style: const TextStyle(
                                color: AppColors.muted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
