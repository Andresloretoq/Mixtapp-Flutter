import 'package:material_ui/material_ui.dart';

import '../data/demo_data.dart';
import '../theme/app_theme.dart';

void showFeedback(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.tint = AppColors.magenta,
  });
  final Widget child;
  final Color tint;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: AppColors.background,
      gradient: RadialGradient(
        center: const Alignment(-.9, -1),
        radius: 1.2,
        colors: [tint.withValues(alpha: .27), AppColors.background],
      ),
    ),
    child: Material(type: MaterialType.transparency, child: child),
  );
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader(
    this.title, {
    super.key,
    this.actions = const [],
    this.back,
  });
  final String title;
  final List<Widget> actions;
  final VoidCallback? back;
  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.bar,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        if (back != null)
          IconButton(
            onPressed: back,
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Volver',
          ),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: title == 'Mixtapp' ? AppColors.pink : null,
              fontWeight: title == 'Mixtapp'
                  ? FontWeight.w900
                  : FontWeight.w700,
            ),
          ),
        ),
        ...actions,
      ],
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.action, this.onAction});
  final String text;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(text, style: Theme.of(context).textTheme.titleLarge),
      ),
      if (action != null) TextButton(onPressed: onAction, child: Text(action!)),
    ],
  );
}

class Cover extends StatelessWidget {
  const Cover(this.image, {super.key, this.size, this.radius = 16, this.label});
  final String image;
  final double? size;
  final double radius;
  final String? label;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: Image.asset(
      'assets/images/$image.jpg',
      width: size,
      height: size,
      fit: BoxFit.cover,
      semanticLabel: label,
      errorBuilder: (context, error, stack) => Container(
        width: size,
        height: size,
        color: AppColors.elevated,
        child: const Center(child: Icon(Icons.album, size: 40)),
      ),
    ),
  );
}

class Surface extends StatelessWidget {
  const Surface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: AppColors.surface.withValues(alpha: .85),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFF542132)),
    ),
    child: Material(type: MaterialType.transparency, child: child),
  );
}

class Stars extends StatelessWidget {
  const Stars(this.rating, {super.key, this.size = 18, this.onChanged});
  final int rating;
  final double size;
  final ValueChanged<int>? onChanged;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (i) {
      final icon = Icon(
        i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
        size: size,
        color: AppColors.pink,
      );
      return onChanged == null
          ? icon
          : IconButton(
              tooltip: '${i + 1} estrellas',
              onPressed: () => onChanged!(i + 1),
              icon: icon,
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            );
    }),
  );
}

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
  });
  final List<String> labels;
  final String selected;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: labels
          .map(
            (label) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(label),
                selected: label == selected,
                showCheckmark: false,
                selectedColor: AppColors.pink,
                labelStyle: TextStyle(
                  color: label == selected
                      ? AppColors.background
                      : AppColors.text,
                ),
                onSelected: (_) => onSelected(label),
                shape: const StadiumBorder(),
              ),
            ),
          )
          .toList(),
    ),
  );
}

class AlbumRow extends StatelessWidget {
  const AlbumRow(this.item, {super.key, this.onTap, this.trailing});
  final MusicItem item;
  final VoidCallback? onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Cover(item.image, size: 56, radius: 12, label: item.title),
    title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
    subtitle: Text(item.artist, style: const TextStyle(color: AppColors.muted)),
    trailing: trailing,
    onTap: onTap,
  );
}

class ReviewCard extends StatefulWidget {
  const ReviewCard(this.review, {super.key});
  final Review review;
  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    final review = widget.review;
    return Surface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.elevated,
                foregroundColor: AppColors.pink,
                child: Text(review.initials),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      review.time,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Stars(review.rating, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          AlbumRow(review.item),
          const SizedBox(height: 6),
          Text(review.text),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() => liked = !liked),
                tooltip: liked ? 'Quitar me gusta' : 'Me gusta',
                icon: Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.pink,
                  size: 22,
                ),
              ),
              Text('${review.likes + (liked ? 1 : 0)}'),
              const SizedBox(width: 16),
              const Icon(
                Icons.chat_bubble_outline,
                size: 20,
                color: AppColors.muted,
              ),
              const SizedBox(width: 8),
              const Text('3'),
            ],
          ),
        ],
      ),
    );
  }
}
