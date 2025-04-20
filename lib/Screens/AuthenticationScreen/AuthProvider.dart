import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => true);
final selectedRoleProvider = StateProvider<String>((ref) => 'Worker');
