import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Bottom sheet menu for exercise actions
class ExerciseMenuSheet extends StatelessWidget {
  final VoidCallback onReplace;
  final VoidCallback onRemove;
  final VoidCallback onViewDetails;

  const ExerciseMenuSheet({
    super.key,
    required this.onReplace,
    required this.onRemove,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.white30,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            ListTile(
              leading: const Icon(Icons.swap_horiz, color: AppColors.cyberLime),
              title: const Text(
                'Replace Exercise',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                onReplace();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.neonCrimson),
              title: const Text(
                'Remove Exercise',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                onRemove();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: AppColors.cyberLime),
              title: const Text(
                'View Details',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                onViewDetails();
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

