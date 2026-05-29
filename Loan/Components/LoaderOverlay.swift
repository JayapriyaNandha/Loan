//
//  LoaderOverlay.swift
//  Loan
//
//  Created by JayaKoushik on 28/05/26.
//


import UIKit

final class LoaderOverlay {

    static let shared = LoaderOverlay()

    private var overlayView: UIView?
    private var activityIndicator: UIActivityIndicatorView?

    private init() {}

    func show() {
        guard let windowScene = UIApplication.shared.connectedScenes
                .first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        if overlayView != nil { return }

        let overlay = UIView(frame: window.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.startAnimating()

        overlay.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])

        window.addSubview(overlay)

        self.overlayView = overlay
        self.activityIndicator = indicator
    }

    func hide() {
        activityIndicator?.stopAnimating()
        overlayView?.removeFromSuperview()
        overlayView = nil
        activityIndicator = nil
    }
}

