class MusicItem {
  const MusicItem(this.title, this.artist, this.image, this.genre, this.year);
  final String title;
  final String artist;
  final String image;
  final String genre;
  final int year;
}

class Review {
  const Review({
    required this.author,
    required this.initials,
    required this.text,
    required this.item,
    this.rating = 5,
    this.likes = 12,
    this.time = 'Hace 2 horas',
  });
  final String author;
  final String initials;
  final String text;
  final MusicItem item;
  final int rating;
  final int likes;
  final String time;
}

abstract final class DemoData {
  static const fromZero = MusicItem(
    'From Zero',
    'Linkin Park',
    'from_zero',
    'Nu metal',
    2024,
  );
  static const emptiness = MusicItem(
    'The Emptiness Machine',
    'Linkin Park',
    'from_zero',
    'Nu metal',
    2024,
  );
  static const karol = MusicItem(
    'NO ME ARREPIENTO DE SENTIR TANTO',
    'KAROL G',
    'karol',
    'Reggaetón',
    2026,
  );
  static const master = MusicItem(
    'Master of Puppets',
    'Metallica',
    'metal',
    'Metal',
    1986,
  );
  static const follow = MusicItem(
    'Follow the Leader',
    'Korn',
    'nu_metal',
    'Nu metal',
    1998,
  );
  static const rock = MusicItem(
    'Rock para volver a empezar',
    'Selección Mixtapp',
    'rock',
    'Rock',
    2024,
  );
  static const catalog = [fromZero, karol, master, follow, emptiness, rock];
  static const reviews = [
    Review(
      author: 'Diego Alfaro',
      initials: 'DA',
      item: fromZero,
      text: 'Un nuevo comienzo que se siente enorme. La energía de Emily y los detalles de Mike hacen que quiera escucharlo otra vez.',
      likes: 24,
    ),
    Review(
      author: 'Valentina Torres',
      initials: 'VT',
      item: karol,
      rating: 4,
      text: 'Hay canciones que te acompañan justo cuando las necesitas. Este disco es una de ellas.',
      likes: 18,
      time: 'Hace 4 horas',
    ),
    Review(
      author: 'Emilia Guerrero',
      initials: 'EG',
      item: master,
      text: 'Cada riff sigue sonando tan poderoso como la primera vez. Un álbum al que siempre regreso.',
      likes: 36,
      time: 'Ayer',
    ),
  ];
}
