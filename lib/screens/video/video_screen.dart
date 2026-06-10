import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/haptic_service.dart';
import '../../services/media_picker_service.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/banner_ad_bar.dart';
import '../../widgets/empty_state.dart';
import 'video_player_screen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final _mediaPicker = MediaPickerService();
  bool _isPicking = false;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _chooseVideo() async {
    setState(() {
      _isPicking = true;
      _errorMessage = null;
    });

    final file = await _mediaPicker.pickVideo(context);
    if (!mounted) return;
    setState(() => _isPicking = false);

    if (file == null) {
      _showMessage(context.l10n.noVideoCancelled);
      return;
    }

    await HapticService.lightImpact();
    if (!mounted) return;

    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;

    if (!file.existsSync()) {
      setState(() {
        _isLoading = false;
        _errorMessage = context.l10n.videoNotFound;
      });
      return;
    }

    setState(() => _isLoading = false);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => VideoPlayerScreen(videoFile: file),
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
      appBar: FeatureAppBar(title: l10n.video),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          padding,
          8,
          padding,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          if (_isLoading)
            SizedBox(
              height: compact ? 220 : 260,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(l10n.openingVideo),
                  ],
                ),
              ),
            )
          else if (_errorMessage != null)
            EmptyStateView(
              icon: Icons.error_outline_rounded,
              title: l10n.videoCannotPlay,
              message: _errorMessage!,
              action: PrimaryActionButton(
                label: l10n.chooseAnotherVideo,
                icon: Icons.videocam_outlined,
                onPressed: _chooseVideo,
              ),
            )
          else
            SizedBox(
              height: compact ? 260 : 320,
              child: EmptyStateView(
                icon: Icons.videocam_outlined,
                title: l10n.noVideoSelected,
                message: l10n.chooseVideoMessage,
              ),
            ),
          if (_isPicking)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (!_isLoading && _errorMessage == null)
            PrimaryActionButton(
              label: l10n.chooseVideo,
              icon: Icons.video_library_outlined,
              onPressed: _chooseVideo,
            ),
          SizedBox(height: compact ? 14 : 18),
          InfoCard(
            title: l10n.castWithAirplay,
            icon: Icons.cast_rounded,
            children: [
              Text(
                l10n.castVideoBody,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'video'),
    );
  }
}
