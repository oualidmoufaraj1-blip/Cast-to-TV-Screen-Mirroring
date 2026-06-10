import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/haptic_service.dart';
import '../../services/media_picker_service.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/banner_ad_bar.dart';
import '../../widgets/empty_state.dart';
import 'photo_preview_screen.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final _mediaPicker = MediaPickerService();
  bool _isPicking = false;

  Future<void> _choosePhoto() async {
    setState(() => _isPicking = true);
    final file = await _mediaPicker.pickPhoto(context);
    if (!mounted) return;
    setState(() => _isPicking = false);

    if (file == null) {
      _showMessage(context.l10n.noPhotoCancelled);
      return;
    }

    await HapticService.lightImpact();
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PhotoPreviewScreen(imageFile: file),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: context.screenBackground,
      appBar: FeatureAppBar(title: l10n.photo),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          padding,
          8,
          padding,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          SizedBox(
            height: compact ? 220 : 260,
            child: EmptyStateView(
              icon: Icons.photo_outlined,
              title: l10n.noPhotoSelected,
              message: l10n.choosePhotoMessage,
            ),
          ),
          if (_isPicking)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            PrimaryActionButton(
              label: l10n.choosePhoto,
              icon: Icons.photo_library_outlined,
              onPressed: _choosePhoto,
            ),
          SizedBox(height: compact ? 14 : 18),
          InfoCard(
            title: l10n.airplay,
            icon: Icons.airplay_rounded,
            children: [
              Text(
                l10n.tapAirplayPhoto,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.secondaryText,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.chooseAirplayDevice,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: context.primaryText,
                      ),
                    ),
                  ),
                  const AirPlayRoutePicker(width: 48, height: 48),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                l10n.photoAirplayHint,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: context.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'photo'),
    );
  }
}
