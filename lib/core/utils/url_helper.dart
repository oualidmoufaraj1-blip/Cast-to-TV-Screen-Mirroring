class UrlHelper {
  static String? normalizeBrowserUrl(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return null;

    final withScheme = trimmed.contains('://') ? trimmed : 'https://$trimmed';
    final uri = Uri.tryParse(withScheme);
    if (uri == null || uri.host.isEmpty) return null;

    return uri.hasScheme ? uri.toString() : 'https://${uri.host}${uri.path}';
  }
}
