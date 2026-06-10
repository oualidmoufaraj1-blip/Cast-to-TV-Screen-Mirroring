enum LinkVideoPlatform { youtube, vimeo }

class LinkValidator {
  static bool isValidYoutubeUrl(String input) {
    final uri = _parseUri(input);
    if (uri == null) return false;

    final host = uri.host.replaceFirst('www.', '').toLowerCase();
    if (host == 'youtu.be') {
      return uri.pathSegments.isNotEmpty;
    }
    if (host == 'youtube.com' || host == 'm.youtube.com') {
      if (uri.pathSegments.isEmpty) return false;
      if (uri.pathSegments.first == 'watch') {
        return uri.queryParameters.containsKey('v');
      }
      return {'embed', 'shorts', 'live'}.contains(uri.pathSegments.first);
    }
    return false;
  }

  static bool isValidVimeoUrl(String input) {
    final uri = _parseUri(input);
    if (uri == null) return false;

    final host = uri.host.replaceFirst('www.', '').toLowerCase();
    if (host != 'vimeo.com' && host != 'player.vimeo.com') {
      return false;
    }

    final id = _vimeoId(uri);
    return id != null && RegExp(r'^\d+$').hasMatch(id);
  }

  static bool isValidForPlatform(String input, LinkVideoPlatform platform) {
    return switch (platform) {
      LinkVideoPlatform.youtube => isValidYoutubeUrl(input),
      LinkVideoPlatform.vimeo => isValidVimeoUrl(input),
    };
  }

  static String? normalizeUrl(String input, LinkVideoPlatform platform) {
    final trimmed = input.trim();
    if (!isValidForPlatform(trimmed, platform)) {
      return null;
    }

    final uri = _parseUri(trimmed)!;
    return switch (platform) {
      LinkVideoPlatform.youtube => _normalizeYoutube(uri),
      LinkVideoPlatform.vimeo => _normalizeVimeo(uri),
    };
  }

  static String platformLabel(LinkVideoPlatform platform) {
    return switch (platform) {
      LinkVideoPlatform.youtube => 'YouTube',
      LinkVideoPlatform.vimeo => 'Vimeo',
    };
  }

  static String platformHint(LinkVideoPlatform platform) {
    return switch (platform) {
      LinkVideoPlatform.youtube => 'https://www.youtube.com/watch?v=...',
      LinkVideoPlatform.vimeo => 'https://vimeo.com/123456789',
    };
  }

  static Uri? _parseUri(String input) {
    final value = input.trim();
    if (value.isEmpty) return null;
    final withScheme = value.contains('://') ? value : 'https://$value';
    return Uri.tryParse(withScheme);
  }

  static String _normalizeYoutube(Uri uri) {
    final host = uri.host.replaceFirst('www.', '').toLowerCase();
    if (host == 'youtu.be') {
      return 'https://www.youtube.com/watch?v=${uri.pathSegments.first}';
    }
    if (uri.pathSegments.first == 'watch') {
      return 'https://www.youtube.com/watch?v=${uri.queryParameters['v']}';
    }
    return uri.replace(scheme: 'https').toString();
  }

  static String _normalizeVimeo(Uri uri) {
    final id = _vimeoId(uri);
    return 'https://vimeo.com/$id';
  }

  static String? _vimeoId(Uri uri) {
    if (uri.host.contains('player.vimeo.com') &&
        uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'video') {
      return uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
    }
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
  }
}
