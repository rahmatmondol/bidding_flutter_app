// Create a new file: lib/app/components/cached_profile_image.dart
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedProfileImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Key? imageKey;

  const CachedProfileImage({
    super.key,
    required this.imageUrl,
    this.radius = 60,
    this.imageKey,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: LightThemeColors.secounderyColor,
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                key: imageKey,
                // Use key to force refresh
                width: radius * 2.r,
                height: radius * 2.r,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Image load error: $error');
                  return _buildDefaultIcon();
                },
              )
            : _buildDefaultIcon(),
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Icon(
      Icons.person,
      size: radius.r,
      color: LightThemeColors.whiteColor,
    );
  }
}
