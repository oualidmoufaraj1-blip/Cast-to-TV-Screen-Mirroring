import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_helper.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/haptic_service.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/banner_ad_bar.dart';
import '../../widgets/empty_state.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({
    super.key,
    this.initialUrl = AppConstants.browserHomeUrl,
  });

  final String initialUrl;

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  late final WebViewController _controller;
  late final TextEditingController _urlController;
  bool _isLoading = true;
  bool _canGoBack = false;
  bool _canGoForward = false;
  double _progress = 0;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.initialUrl);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (!mounted) return;
            setState(() => _progress = progress / 100);
          },
          onPageStarted: (_) {
            if (!mounted) return;
            setState(() {
              _isLoading = true;
              _loadError = null;
            });
          },
          onPageFinished: (_) => _updateNavigationState(),
          onWebResourceError: (error) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _loadError = error.description.isNotEmpty
                  ? error.description
                  : context.l10n.pageLoadFailed;
            });
          },
          onNavigationRequest: (request) => NavigationDecision.navigate,
        ),
      );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialUrl(widget.initialUrl);
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialUrl(String url) async {
    final normalized = UrlHelper.normalizeBrowserUrl(url);
    if (normalized == null) {
      setState(() {
        _loadError = context.l10n.invalidUrl;
        _isLoading = false;
      });
      return;
    }
    await _controller.loadRequest(Uri.parse(normalized));
  }

  Future<void> _updateNavigationState() async {
    final canGoBack = await _controller.canGoBack();
    final canGoForward = await _controller.canGoForward();
    final currentUrl = await _controller.currentUrl();
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _canGoBack = canGoBack;
      _canGoForward = canGoForward;
      if (currentUrl != null) {
        _urlController.text = currentUrl;
      }
    });
  }

  Future<void> _loadUrl() async {
    final normalized = UrlHelper.normalizeBrowserUrl(_urlController.text);
    if (normalized == null) {
      setState(() {
        _loadError = context.l10n.invalidUrlExample;
      });
      return;
    }

    await HapticService.selectionClick();
    if (!mounted) return;
    FocusScope.of(context).unfocus();
    setState(() => _loadError = null);
    await _controller.loadRequest(Uri.parse(normalized));
  }

  Future<void> _goHome() async {
    await HapticService.selectionClick();
    _urlController.text = AppConstants.browserHomeUrl;
    await _loadUrl();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);

    return Scaffold(
      backgroundColor: context.screenBackground,
      appBar: FeatureAppBar(
        title: l10n.browser,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: AirPlayRoutePicker(width: 40, height: 40),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isLoading)
            LinearProgressIndicator(
              value: _progress > 0 ? _progress : null,
              minHeight: 3,
              backgroundColor: Colors.transparent,
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.horizontalPadding(context),
              8,
              Responsive.horizontalPadding(context),
              8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: l10n.enterUrl,
                      filled: true,
                      fillColor: context.cardColor,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: compact ? 8 : 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: context.primaryText),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (_) => _loadUrl(),
                    autocorrect: false,
                    keyboardType: TextInputType.url,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _loadUrl,
                  icon: const Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                IconButton(
                  onPressed: _canGoBack
                      ? () {
                          HapticService.selectionClick();
                          _controller.goBack();
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                IconButton(
                  onPressed: _canGoForward
                      ? () {
                          HapticService.selectionClick();
                          _controller.goForward();
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward_rounded),
                ),
                IconButton(
                  onPressed: () {
                    HapticService.selectionClick();
                    _controller.reload();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                ),
                IconButton(
                  onPressed: _goHome,
                  icon: const Icon(Icons.home_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                Responsive.horizontalPadding(context),
                0,
                Responsive.horizontalPadding(context),
                compact ? 12 : 16,
              ),
              child: _loadError != null
                  ? EmptyStateView(
                      icon: Icons.wifi_off_rounded,
                      title: l10n.pageFailedToLoad,
                      message: _loadError!,
                      action: PrimaryActionButton(
                        label: l10n.tryAgain,
                        icon: Icons.refresh_rounded,
                        onPressed: _loadUrl,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: WebViewWidget(controller: _controller),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'browser'),
    );
  }
}
