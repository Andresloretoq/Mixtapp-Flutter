import 'package:material_ui/material_ui.dart';

import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import '../widgets/components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.onAlbum,
    required this.onLogin,
  });
  final ValueChanged<MusicItem> onAlbum;
  final VoidCallback onLogin;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String tab = 'Perfil';
  @override
  Widget build(BuildContext context) => AppBackground(
    tint: const Color(0xFFC462AA),
    child: Column(
      children: [
        ScreenHeader(
          'Perfil',
          actions: [
            IconButton(
              tooltip: 'Ajustes',
              onPressed: () => showFeedback(
                context,
                'Perfil de demostración · Emilia Guerrero',
              ),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 90),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: AppColors.elevated,
                    foregroundColor: AppColors.pink,
                    child: Icon(Icons.person_rounded, size: 64),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emilia Guerrero',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Text(
                          '@emiliag',
                          style: TextStyle(color: AppColors.pink),
                        ),
                        const SizedBox(height: 8),
                        const Wrap(
                          spacing: 16,
                          runSpacing: 4,
                          children: [
                            Text('128 seguidores'),
                            Text('25 seguidos'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Siempre hay una canción para cada momento. Rock, conciertos y discos que se quedan contigo.',
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 16,
                    color: AppColors.pink,
                  ),
                  SizedBox(width: 6),
                  Text('@emiliag', style: TextStyle(color: AppColors.pink)),
                ],
              ),
              const SizedBox(height: 24),
              FilterRow(
                labels: const ['Perfil', 'Guardados', 'Mixtapes'],
                selected: tab,
                onSelected: (value) => setState(() => tab = value),
              ),
              const SizedBox(height: 20),
              if (tab == 'Perfil') ...[
                Surface(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.pink,
                    ),
                    title: const Text('Tu año en Mixtapp'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => showFeedback(
                      context,
                      'Este año descubriste 42 álbumes y escribiste 18 reseñas.',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const SectionTitle('Favoritos'),
                const SizedBox(height: 12),
                SizedBox(
                  height: 190,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (_, index) => const SizedBox(width: 12),
                    itemBuilder: (context, i) {
                      final item = [
                        DemoData.fromZero,
                        DemoData.master,
                        DemoData.follow,
                      ][i];
                      return SizedBox(
                        width: 112,
                        child: InkWell(
                          onTap: () => widget.onAlbum(item),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Cover(item.image, size: 112),
                              const SizedBox(height: 8),
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item.artist,
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const SectionTitle('Actividad reciente'),
                const SizedBox(height: 12),
                ReviewCard(DemoData.reviews.last),
              ] else if (tab == 'Guardados') ...[
                const Text(
                  'La música que quieres escuchar después.',
                  style: TextStyle(color: AppColors.muted),
                ),
                ...[DemoData.karol, DemoData.follow].map(
                  (item) => AlbumRow(
                    item,
                    onTap: () => widget.onAlbum(item),
                    trailing: const Icon(Icons.bookmark, color: AppColors.pink),
                  ),
                ),
              ] else ...[
                Surface(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Cover('from_zero', size: 100),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Para entrenar',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const Text(
                                  '8 canciones · Pública',
                                  style: TextStyle(color: AppColors.muted),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Un poco más de energía para cada día.'),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 28),
              OutlinedButton.icon(
                onPressed: widget.onLogin,
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
