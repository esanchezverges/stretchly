import 'dart:math';
import 'stretch.dart';

abstract final class StretchCatalog {
  static const all = [
    // ── Cuello ───────────────────────────────────────────────────────────────
    Stretch(
      name: 'Inclinación lateral del cuello',
      duration: '30s × 2',
      description: 'Inclina la oreja hacia el hombro suavemente para estirar el trapecio superior.',
      category: StretchCategory.neck,
    ),
    Stretch(
      name: 'Flexión cervical',
      duration: '30s',
      description: 'Baja la barbilla al pecho para elongar la nuca y la parte posterior del cuello.',
      category: StretchCategory.neck,
    ),
    Stretch(
      name: 'Rotación suave de cuello',
      duration: '30s × 2',
      description: 'Gira la cabeza de lado a lado con movimientos lentos y controlados.',
      category: StretchCategory.neck,
    ),
    Stretch(
      name: 'Autoelongación sentado',
      duration: '45s',
      description: 'Siéntate erguido, alarga la columna como si el techo te tirara de la coronilla.',
      category: StretchCategory.back,
    ),

    // ── Hombros ───────────────────────────────────────────────────────────────
    Stretch(
      name: 'Brazo cruzado al pecho',
      duration: '30s × 2',
      description: 'Lleva un brazo al pecho y usa el otro para incrementar el estiramiento del deltoides posterior.',
      category: StretchCategory.shoulders,
    ),
    Stretch(
      name: 'Estiramiento de tríceps',
      duration: '30s × 2',
      description: 'Lleva el codo detrás de la cabeza y presiona suavemente para estirar el tríceps.',
      category: StretchCategory.shoulders,
    ),
    Stretch(
      name: 'Brazos entrelazados detrás',
      duration: '45s',
      description: 'Entrelaza los dedos detrás de la espalda, extiende los brazos y abre el pecho.',
      category: StretchCategory.shoulders,
    ),
    Stretch(
      name: 'Postura del águila (brazos)',
      duration: '30s × 2',
      description: 'Enrosca los antebrazos y eleva los codos para estirar la escápula y los hombros profundamente.',
      category: StretchCategory.shoulders,
    ),

    // ── Pecho ─────────────────────────────────────────────────────────────────
    Stretch(
      name: 'Apertura de pecho de rodillas',
      duration: '45s',
      description: 'Desde rodillas, apoya un brazo en el suelo y rota el torso hacia arriba abriendo el pecho.',
      category: StretchCategory.chest,
    ),
    Stretch(
      name: 'Postura del cachorro extendido',
      duration: '60s',
      description: 'Desde cuatro patas, desliza las manos hacia delante y baja el pecho al suelo.',
      category: StretchCategory.chest,
    ),

    // ── Espalda ───────────────────────────────────────────────────────────────
    Stretch(
      name: 'Gato-vaca',
      duration: '60s',
      description: 'Alterna entre arquear y redondear la espalda al ritmo de la respiración para movilizar la columna.',
      category: StretchCategory.back,
    ),
    Stretch(
      name: 'Postura del niño',
      duration: '60s',
      description: 'Siéntate sobre los talones y estira los brazos al frente para elongar toda la espalda.',
      category: StretchCategory.back,
    ),
    Stretch(
      name: 'Perro boca abajo',
      duration: '45s',
      description: 'Forma una V invertida con el cuerpo, alargando la columna y los isquiotibiales.',
      category: StretchCategory.back,
    ),
    Stretch(
      name: 'Torsión espinal tumbado',
      duration: '30s × 2',
      description: 'Tumbado boca arriba, lleva una rodilla al lado opuesto del cuerpo para rotar la columna.',
      category: StretchCategory.back,
    ),
    Stretch(
      name: 'Postura de la cobra',
      duration: '45s',
      description: 'Tumbado boca abajo, eleva el pecho con los brazos extendidos para estirar el abdomen y la lumbar.',
      category: StretchCategory.back,
    ),
    Stretch(
      name: 'Postura de la esfinge',
      duration: '60s',
      description: 'Variante suave de la cobra apoyando los antebrazos, ideal para la lumbar y el core anterior.',
      category: StretchCategory.back,
    ),

    // ── Caderas ───────────────────────────────────────────────────────────────
    Stretch(
      name: 'Estocada baja (low lunge)',
      duration: '45s × 2',
      description: 'Un pie al frente en ángulo recto, la rodilla trasera en el suelo para abrir el flexor de cadera.',
      category: StretchCategory.hips,
    ),
    Stretch(
      name: 'Estocada baja con rodilla apoyada',
      duration: '45s × 2',
      description: 'Como la estocada baja pero con la mano en el muslo trasero para profundizar en el flexor.',
      category: StretchCategory.hips,
    ),
    Stretch(
      name: 'Figura 4 tumbado',
      duration: '45s × 2',
      description: 'Cruza un tobillo sobre la rodilla contraria y acerca las piernas al pecho para estirar el glúteo.',
      category: StretchCategory.hips,
    ),
    Stretch(
      name: 'Postura de la paloma',
      duration: '60s × 2',
      description: 'Lleva una pierna doblada al frente y extiende la otra atrás para un estiramiento profundo de glúteo y rotadores.',
      category: StretchCategory.hips,
    ),
    Stretch(
      name: 'Mariposa (Baddha Konasana)',
      duration: '60s',
      description: 'Une las plantas de los pies y deja caer las rodillas hacia los lados para abrir los aductores.',
      category: StretchCategory.hips,
    ),
    Stretch(
      name: 'Sentadilla profunda (Malasana)',
      duration: '45s',
      description: 'Pies separados, baja en cuclillas manteniendo el pecho erguido para abrir cadera y tobillos.',
      category: StretchCategory.hips,
    ),

    // ── Piernas ───────────────────────────────────────────────────────────────
    Stretch(
      name: 'Postura del héroe (Virasana)',
      duration: '60s',
      description: 'Siéntate entre los talones con las piernas dobladas bajo el cuerpo para estirar el cuádriceps.',
      category: StretchCategory.legs,
    ),
    Stretch(
      name: 'Flexión hacia delante de pie',
      duration: '45s',
      description: 'De pie, dobla el tronco hacia las piernas manteniendo las rodillas ligeramente flexionadas.',
      category: StretchCategory.legs,
    ),
    Stretch(
      name: 'Flexión sentado (Paschimottanasana)',
      duration: '60s',
      description: 'Sentado con piernas extendidas, inclínate hacia los pies elongando los isquiotibiales.',
      category: StretchCategory.legs,
    ),
    Stretch(
      name: 'Media split (Ardha Hanumanasana)',
      duration: '30s × 2',
      description: 'Desde la estocada baja, extiende la pierna delantera y flexiona el pie para estirar el isquiotibial.',
      category: StretchCategory.legs,
    ),
    Stretch(
      name: 'Perro boca abajo (talones)',
      duration: '45s',
      description: 'En perro boca abajo, presiona los talones al suelo alternando para estirar los gemelos.',
      category: StretchCategory.legs,
    ),
    Stretch(
      name: 'Estiramiento de tobillo',
      duration: '30s × 2',
      description: 'De rodillas, flexiona el pie y siéntate sobre el talón para movilizar el tobillo.',
      category: StretchCategory.legs,
    ),

    // ── Cuerpo completo ───────────────────────────────────────────────────────
    Stretch(
      name: 'Saludo al sol',
      duration: '90s',
      description: 'Secuencia fluida de posturas que calienta y estira todo el cuerpo de arriba a abajo.',
      category: StretchCategory.fullBody,
    ),
    Stretch(
      name: 'Guerrero I',
      duration: '30s × 2',
      description: 'Estocada profunda con brazos elevados que trabaja caderas, piernas y la apertura del pecho.',
      category: StretchCategory.fullBody,
    ),
    Stretch(
      name: 'Guerrero II',
      duration: '30s × 2',
      description: 'Piernas abiertas con rodilla doblada y brazos extendidos para trabajar cadera y hombros.',
      category: StretchCategory.fullBody,
    ),
    Stretch(
      name: 'Triángulo (Trikonasana)',
      duration: '30s × 2',
      description: 'Piernas abiertas, inclínate lateralmente tocando el pie para estirar costado, isquiotibial y cadera.',
      category: StretchCategory.fullBody,
    ),
    Stretch(
      name: 'Media luna',
      duration: '30s × 2',
      description: 'Equilibrio sobre una pierna con el torso paralelo al suelo para trabajar cadera y core.',
      category: StretchCategory.fullBody,
    ),
  ];

  /// Generates a random routine.
  /// If [focusAreas] is provided, ~70% of exercises come from matching categories.
  static List<Stretch> random({
    int count = 10,
    List<String> focusAreas = const [],
  }) {
    final rng = Random();

    if (focusAreas.isEmpty) {
      return ([...all]..shuffle(rng)).take(count).toList();
    }

    final focus = [...all.where((s) => _matchesFocus(s, focusAreas))]..shuffle(rng);
    final rest  = [...all.where((s) => !_matchesFocus(s, focusAreas))]..shuffle(rng);

    final focusCount = (count * 0.7).round().clamp(0, focus.length);
    final restCount  = (count - focusCount).clamp(0, rest.length);

    final result = [...focus.take(focusCount), ...rest.take(restCount)];

    // Top-up if there weren't enough focus exercises
    if (result.length < count) {
      final extra = rest.skip(restCount).take(count - result.length);
      result.addAll(extra);
    }

    return result..shuffle(rng);
  }

  static bool _matchesFocus(Stretch s, List<String> focusAreas) {
    final cat = s.category.toLowerCase();
    return focusAreas.any((fa) {
      final f = fa.toLowerCase();
      return cat == f || cat.contains(f) || f.contains(cat);
    });
  }
}
