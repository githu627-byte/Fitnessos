import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to track which card slot user wants to commit to
/// Used when navigating from empty card to workouts tab
final selectedCardSlotProvider = StateProvider<String?>((ref) => null);
