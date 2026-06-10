import AVKit
import Flutter
import UIKit

final class AirPlayRoutePickerViewFactory: NSObject, FlutterPlatformViewFactory {
  private weak var messenger: FlutterBinaryMessenger?

  init(messenger: FlutterBinaryMessenger?) {
    self.messenger = messenger
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    AirPlayRoutePickerPlatformView(frame: frame)
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }
}

final class AirPlayRoutePickerPlatformView: NSObject, FlutterPlatformView {
  private let containerView: UIView

  init(frame: CGRect) {
    let routePickerView = AVRoutePickerView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    routePickerView.activeTintColor = UIColor.systemBlue
    routePickerView.tintColor = UIColor.label

    containerView = UIView(frame: frame)
    containerView.backgroundColor = .clear
    routePickerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(routePickerView)

    NSLayoutConstraint.activate([
      routePickerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      routePickerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      routePickerView.widthAnchor.constraint(equalToConstant: 44),
      routePickerView.heightAnchor.constraint(equalToConstant: 44),
    ])

    super.init()
  }

  func view() -> UIView {
    containerView
  }
}

final class AirPlayVideoPlayerViewFactory: NSObject, FlutterPlatformViewFactory {
  private weak var messenger: FlutterBinaryMessenger?

  init(messenger: FlutterBinaryMessenger?) {
    self.messenger = messenger
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    AirPlayVideoPlayerPlatformView(frame: frame, arguments: args)
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }
}

final class AirPlayVideoPlayerPlatformView: NSObject, FlutterPlatformView {
  private let playerViewController: AVPlayerViewController

  init(frame: CGRect, arguments: Any?) {
    playerViewController = AVPlayerViewController()
    playerViewController.view.frame = frame
    playerViewController.showsPlaybackControls = true
    playerViewController.allowsPictureInPicturePlayback = true

    if let args = arguments as? [String: Any],
       let filePath = args["filePath"] as? String {
      let url = URL(fileURLWithPath: filePath)
      let player = AVPlayer(url: url)
      player.allowsExternalPlayback = true
      player.usesExternalPlaybackWhileExternalScreenIsActive = true
      playerViewController.player = player
      player.play()
    }

    super.init()
  }

  func view() -> UIView {
    playerViewController.view
  }
}

enum AirPlayPlugin {
  static func register(with registry: FlutterPluginRegistry) {
    guard let registrar = registry.registrar(forPlugin: "AirPlayPlugin") else {
      return
    }

    registrar.register(
      AirPlayRoutePickerViewFactory(messenger: registrar.messenger()),
      withId: "AirPlayRoutePickerView"
    )
    registrar.register(
      AirPlayVideoPlayerViewFactory(messenger: registrar.messenger()),
      withId: "AirPlayVideoPlayerView"
    )
  }
}
