import 'package:material_ui/material_ui.dart';

import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import '../widgets/components.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({
    super.key,
    required this.item,
    required this.onBack,
  });
  final MusicItem item;
  final VoidCallback onBack;
  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final form = GlobalKey<FormState>();
  final text = TextEditingController();
  int rating = 0;
  DateTime? date;
  bool location = false;
  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AppBackground(
    tint: AppColors.violet,
    child: Column(
      children: [
        ScreenHeader('Escribir reseña', back: widget.onBack),
        Expanded(
          child: Form(
            key: form,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Surface(
                  child: AlbumRow(
                    widget.item,
                    trailing: Text(
                      '${widget.item.year}',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const SectionTitle('Tu calificación'),
                const SizedBox(height: 12),
                Center(
                  child: Stars(
                    rating,
                    size: 34,
                    onChanged: (value) =>
                        setState(() => rating = value == rating ? 0 : value),
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: date ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      locale: const Locale('es'),
                    );
                    if (selected != null && mounted) {
                      setState(() => date = selected);
                    }
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: Text(
                    date == null
                        ? 'Fecha de escucha (opcional)'
                        : '${date!.year}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: text,
                  maxLength: 500,
                  minLines: 5,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Reseña',
                    hintText: '¿Qué te hizo sentir?',
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Escribe tu reseña antes de publicar.'
                      : null,
                ),
                const SizedBox(height: 16),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  value: location,
                  onChanged: (value) => setState(() => location = value),
                  title: const Text('Compartir ubicación'),
                  subtitle: Text(
                    location
                        ? 'Bogotá · ubicación de ejemplo'
                        : 'Añade tu reseña al mapa',
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onBack,
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Reseña lista'),
                                content: Text(
                                  'Tu reseña de ${widget.item.title} tiene $rating estrellas. Esta demostración guarda los cambios solo mientras usas la pantalla.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Entendido'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text('Publicar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
