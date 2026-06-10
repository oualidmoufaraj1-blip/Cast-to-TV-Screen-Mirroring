import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/haptic_service.dart';
import '../../services/media_picker_service.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/empty_state.dart';

class PhotoPreviewScreen extends StatefulWidget {
  const PhotoPreviewScreen({super.key, required this.imageFile});

  final File imageFile;

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  final _mediaPicker = MediaPickerService();
  late File _imageFile;
  bool _isPicking = false;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  Future<void> _chooseAnotherPhoto() async {
    setState(() => _isPicking = true);
    final file = await _mediaPicker.pickPhoto(context);
    if (!mounted) return;
    setState(() => _isPicking = false);

    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.photoStillShown)),
      );
      return;
    }

    await HapticService.lightImpact();
    setState(() => _imageFile = file);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: context.screenBackground,
      appBar: FeatureAppBar(title: l10n.photoPreview),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          padding,
          8,
          padding,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.file(_imageFile, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: compact ? 14 : 18),
          PrimaryActionButton(
            label: l10n.chooseAnotherPhoto,
            icon: Icons.photo_library_outlined,
            onPressed: _isPicking ? () {} : _chooseAnotherPhoto,
            outlined: true,
          ),
          if (_isPicking)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Center(child: CircularProgressIndicator()),
            ),
          SizedBox(height: compact ? 14 : 18),
          InfoCard(
            title: l10n.showOnTv,
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
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
    );
  }
}
