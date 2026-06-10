import 'package:flutter/material.dart';

import '../../core/navigation/navigation_helper.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/link_validator.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/haptic_service.dart';
import '../../widgets/banner_ad_bar.dart';
import '../../widgets/empty_state.dart';
import '../browser/browser_screen.dart';

class LinkVideoScreen extends StatefulWidget {
  const LinkVideoScreen({super.key, required this.platform});

  final LinkVideoPlatform platform;

  @override
  State<LinkVideoScreen> createState() => _LinkVideoScreenState();
}

class _LinkVideoScreenState extends State<LinkVideoScreen> {
  final _controller = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _platformLabel(BuildContext context) {
    final l10n = context.l10n;
    return widget.platform == LinkVideoPlatform.youtube ? l10n.youtube : l10n.vimeo;
  }

  Future<void> _openLink() async {
    final l10n = context.l10n;
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        _errorText = l10n.pasteLinkFirst;
      });
      return;
    }

    if (!LinkValidator.isValidForPlatform(input, widget.platform)) {
      setState(() {
        _errorText = widget.platform == LinkVideoPlatform.youtube
            ? l10n.invalidYoutubeLink
            : l10n.invalidVimeoLink;
      });
      return;
    }

    final url = LinkValidator.normalizeUrl(input, widget.platform);
    if (url == null) {
      setState(() {
        _errorText = l10n.invalidLink;
      });
      return;
    }

    await HapticService.lightImpact();
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BrowserScreen(initialUrl: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final label = _platformLabel(context);
    final compact = Responsive.isCompact(context);

    return Scaffold(
      backgroundColor: context.screenBackground,
      appBar: AppBar(
        backgroundColor: context.screenBackground,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: context.primaryText),
          onPressed: () => NavigationHelper.popWithInterstitial(context),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.primaryText,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          Responsive.horizontalPadding(context),
          8,
          Responsive.horizontalPadding(context),
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          Text(
            l10n.pasteLinkDescription(label),
            style: TextStyle(
              fontSize: compact ? 13 : 14,
              height: 1.5,
              color: context.secondaryText,
            ),
          ),
          SizedBox(height: compact ? 16 : 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: l10n.linkLabel(label),
              hintText: LinkValidator.platformHint(widget.platform),
              errorText: _errorText,
              filled: true,
              fillColor: context.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: context.primaryText),
            keyboardType: TextInputType.url,
            autocorrect: false,
            onChanged: (_) {
              if (_errorText != null) {
                setState(() => _errorText = null);
              }
            },
          ),
          SizedBox(height: compact ? 16 : 20),
          PrimaryActionButton(
            label: l10n.openInBrowser,
            icon: Icons.open_in_browser_rounded,
            onPressed: _openLink,
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'link_video'),
    );
  }
}
