import 'dart:math';
import 'stretch.dart';

abstract final class StretchCatalog {
  static const all = [
    // Cuello y parte superior
    Stretch(name: 'Inclinación lateral del cuello',    duration: '30s × 2'),
    Stretch(name: 'Flexión cervical',                  duration: '30s'),
    Stretch(name: 'Rotación suave de cuello',          duration: '30s × 2'),
    Stretch(name: 'Autoelongación sentado',            duration: '45s'),

    // Hombros y brazos
    Stretch(name: 'Brazo cruzado al pecho',            duration: '30s × 2'),
    Stretch(name: 'Estiramiento de tríceps',           duration: '30s × 2'),
    Stretch(name: 'Brazos entrelazados detrás',        duration: '45s'),
    Stretch(name: 'Postura del águila (brazos)',       duration: '30s × 2'),

    // Pecho
    Stretch(name: 'Apertura de pecho de rodillas',    duration: '45s'),
    Stretch(name: 'Postura del cachorro extendido',   duration: '60s'),

    // Espalda y core
    Stretch(name: 'Gato-vaca',                        duration: '60s'),
    Stretch(name: 'Postura del niño',                 duration: '60s'),
    Stretch(name: 'Perro boca abajo',                 duration: '45s'),
    Stretch(name: 'Torsión espinal tumbado',          duration: '30s × 2'),

    // Abdomen y flexores de cadera
    Stretch(name: 'Postura de la cobra',              duration: '45s'),
    Stretch(name: 'Postura de la esfinge',            duration: '60s'),
    Stretch(name: 'Estocada baja (low lunge)',        duration: '45s × 2'),

    // Cuádriceps
    Stretch(name: 'Postura del héroe (Virasana)',     duration: '60s'),
    Stretch(name: 'Estocada baja con rodilla apoyada', duration: '45s × 2'),

    // Isquiotibiales
    Stretch(name: 'Flexión hacia delante de pie',     duration: '45s'),
    Stretch(name: 'Flexión sentado (Paschimottanasana)', duration: '60s'),
    Stretch(name: 'Media split (Ardha Hanumanasana)', duration: '30s × 2'),

    // Glúteos
    Stretch(name: 'Figura 4 tumbado',                duration: '45s × 2'),
    Stretch(name: 'Postura de la paloma',             duration: '60s × 2'),

    // Aductores
    Stretch(name: 'Mariposa (Baddha Konasana)',       duration: '60s'),
    Stretch(name: 'Sentadilla profunda (Malasana)',   duration: '45s'),

    // Gemelos y tobillos
    Stretch(name: 'Perro boca abajo (talones)',       duration: '45s'),
    Stretch(name: 'Estiramiento de tobillo',          duration: '30s × 2'),

    // Posturas compuestas
    Stretch(name: 'Saludo al sol',                    duration: '90s'),
    Stretch(name: 'Guerrero I',                        duration: '30s × 2'),
    Stretch(name: 'Guerrero II',                       duration: '30s × 2'),
    Stretch(name: 'Triángulo (Trikonasana)',          duration: '30s × 2'),
    Stretch(name: 'Media luna',                       duration: '30s × 2'),
  ];

  static List<Stretch> random([int count = 10]) {
    final copy = [...all]..shuffle(Random());
    return copy.take(count).toList();
  }
}
