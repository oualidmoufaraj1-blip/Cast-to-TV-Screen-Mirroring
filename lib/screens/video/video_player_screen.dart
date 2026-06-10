import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/navigation/navigation_helper.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/haptic_service.dart';
import '../../services/media_picker_service.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/empty_state.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.videoFile});

  final File videoFile;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final _mediaPicker = MediaPickerService();
  late File _videoFile;
  bool _isReady = false;
  bool _hasError = false;
  bool _isPicking = false;

  @override
  void initState() {
    super.initState();
    _videoFile = widget.videoFile;
    _prepareVideo();
  }

  Future<void> _prepareVideo() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    if (!_videoFile.existsSync()) {
      setState(() {
        _hasError = true;
        _isReady = true;
      });
      return;
    }

    setState(() {
      _hasError = false;
      _isReady = true;
    });
  }

  Future<void> _chooseAnotherVideo() async {
    setState(() => _isPicking = true);
    final file = await _mediaPicker.pickVideo(context);
    if (!mounted) return;
    setState(() => _isPicking = false);

    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.videoStillLoaded)),
      );
      return;
    }

    await HapticService.lightImpact();
    setState(() {
      _videoFile = file;
      _isReady = false;
      _hasError = false;
    });
    await _prepareVideo();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => NavigationHelper.popWithInterstitial(context),
        ),
        title: Text(
          l10n.videoPlayer,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildPlayerArea(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: context.screenBackground,
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  padding,
                  compact ? 14 : 20,
                  padding,
                  MediaQuery.paddingOf(context).bottom + 20,
                ),
                children: [
                  if (!_isReady)
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 12),
                            Text(l10n.loadingVideo),
                          ],
                        ),
                      ),
                    )
                  else if (_hasError)
                    EmptyStateView(
                      icon: Icons.error_outline_rounded,
                      title: l10n.videoCannotPlay,
                      message: l10n.videoCannotOpen,
                      action: PrimaryActionButton(
                        label: l10n.chooseAnotherVideo,
                        icon: Icons.video_library_outlined,
                        onPressed: _isPicking ? () {} : _chooseAnotherVideo,
                      ),
                    )
                  else ...[
                    PrimaryActionButton(
                      label: l10n.chooseAnotherVideo,
                      icon: Icons.video_library_outlined,
                      onPressed: _isPicking ? () {} : _chooseAnotherVideo,
                      outlined: true,
                    ),
                    SizedBox(height: compact ? 14 : 18),
                    InfoCard(
                      title: l10n.castToTv,
                      icon: Icons.cast_rounded,
                      children: [
                        Text(
                          l10n.castVideoPlayerBody,
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
                                l10n.orPickDevice,
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
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerArea() {
    final l10n = context.l10n;
    if (!_isReady) {
      return const ColoredBox(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    if (_hasError) {
      return ColoredBox(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              l10n.unableToPlayVideo,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return AirPlayVideoPlayer(filePath: _videoFile.path);
  }
}
