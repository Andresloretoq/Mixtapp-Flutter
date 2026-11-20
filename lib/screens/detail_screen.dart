import 'package:material_ui/material_ui.dart';

import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import '../widgets/components.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.item,
    required this.onReview,
    required this.onBack,
  });
  final MusicItem item;
  final VoidCallback onReview;
  final VoidCallback onBack;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool liked = false;
  bool saved = false;
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return AppBackground(
      tint: AppColors.violet,
      child: Column(
        children: [
          ScreenHeader('Álbum', back: widget.onBack),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Cover(item.image, radius: 28, label: item.title),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text('${item.year}')),
                    Chip(label: Text(item.genre)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  item.artist,
                  style: const TextStyle(fontSize: 18, color: AppColors.muted),
                ),
                const SizedBox(height: 20),
                Surface(
                  child: Row(
                    children: [
                      _stat('4.8', 'calificación'),
                      _stat('128', 'reseñas'),
                      _stat('96%', 'recomiendan'),
                      _stat(liked ? '1.3K' : '1.2K', 'me gusta'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: widget.onReview,
                        child: const Text('Escribir reseña'),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Me gusta',
                      onPressed: () => setState(() => liked = !liked),
                      icon: Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.pink,
                      ),
                    ),
                    IconButton(
                      tooltip: saved ? 'Quitar de guardados' : 'Guardar álbum',
                      onPressed: () => setState(() => saved = !saved),
                      icon: Icon(
                        saved ? Icons.bookmark : Icons.bookmark_border,
                        color: AppColors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Surface(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: const Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.pink,
                    ),
                    title: const Text('Datos curiosos'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Un nuevo comienzo'),
                        content: Text(
                          item == DemoData.fromZero
                              ? 'From Zero se publicó en 2024. Su nombre hace referencia a Xero, el nombre original de Linkin Park.'
                              : '${item.title} forma parte del catálogo de ${item.genre} de Mixtapp. Artista: ${item.artist}. Año: ${item.year}.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const SectionTitle('Escúchalo'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => showFeedback(
                          context,
                          'Spotify · enlace de demostración',
                        ),
                        icon: const Icon(Icons.headphones),
                        label: const Text('Spotify'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => showFeedback(
                          context,
                          'YouTube · enlace de demostración',
                        ),
                        icon: const Icon(Icons.play_circle_outline),
                        label: const Text('YouTube'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const SectionTitle('Reseñas de la comunidad'),
                const SizedBox(height: 12),
                ReviewCard(
                  Review(
                    author: 'Diego Alfaro',
                    initials: 'DA',
                    item: item,
                    text: DemoData.reviews.first.text,
                    likes: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.pink,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: AppColors.muted),
        ),
      ],
    ),
  );
}
