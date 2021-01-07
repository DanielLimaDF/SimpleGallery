//
//  VideoView.swift
//  
//
//  Created by daniel.da.cunha.lima on 07/01/21.
//

import Foundation
import WebKit
import UIKit

internal class VideoView: UIView {

    let galleryItem: GalleryItem
    let webView: WKWebView

    internal init(item: GalleryItem) {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.allowsAirPlayForMediaPlayback = true
        configuration.allowsPictureInPictureMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []

        webView = WKWebView(frame: .zero, configuration: configuration)
        galleryItem = item
        super.init(frame: .zero)
        setupView()
    }

    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func loadVideo() {
        if let url = galleryItem.videoURL {
            webView.loadVideo(from: url)
        }
    }

    internal func stopVideo() {
        webView.stopVideo()
    }

}

extension VideoView: ViewCoding {

    func buildHierarchy() {
        addViews(webView)
    }

    func setupConstraints() {

        webView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }

    internal func render() {
        backgroundColor = UIColor(red: 0.20, green: 0.24, blue: 0.35, alpha: 1.00)

        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = false
    }

}

internal extension WKWebView {

    func loadVideo(from url: URL) {
        if let videoId = getVideoId(from: url) {
            loadHTMLString(getHTMLString(videoId: videoId), baseURL: nil)
        }
    }

    func stopVideo() {
        loadHTMLString(String(), baseURL: nil)
    }

    private func getHTMLString(videoId: String) -> String {

        return """
            <!DOCTYPE html>
            <html>
                <head>
                    <meta charset="utf-8">
                    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no,minimal-ui,viewport-fit=cover">
                    <meta name="apple-mobile-web-app-capable" content="yes">
                    <meta name="apple-mobile-web-app-status-bar-style" content="black">

                    <style>
                    iframe {
                        width: 100vw;
                        height: 100vh;
                    }
                    body {
                        margin: 0px;
                        padding: 0px;
                    }
                    </style>

                </head>
                <body>
                    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
                    <div id="player"></div>

                    <script>
                        var tag = document.createElement('script');

                        tag.src = "https://www.youtube.com/iframe_api";
                        var firstScriptTag = document.getElementsByTagName('script')[0];
                        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

                        var player;
                        function onYouTubeIframeAPIReady() {
                            player = new YT.Player('player', {
                                playerVars: { 'autoplay': 1, 'controls': 1, 'playsinline': 1, 'rel': 0 },
                                width: '100%',
                                height: '100%',
                                videoId: '\(videoId)',
                                events: {
                                    'onReady': onPlayerReady
                                }
                            });
                        }

                        function onPlayerReady(event) {
                            event.target.playVideo();
                        }
                    </script>
                </body>
            </html>
        """
    }

    private func getVideoId(from url: URL) -> String? {

        guard let urlString = url.absoluteString.removingPercentEncoding else {
            return nil
        }

        do {
            let regex = try NSRegularExpression.init(pattern: "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)", options: .caseInsensitive)
            let range = NSRange(location: 0, length: urlString.count)
            if let matchRange = regex.firstMatch(in: urlString, options: .reportCompletion, range: range)?.range {
                let matchLength = (matchRange.lowerBound + matchRange.length) - 1
                if range.contains(matchRange.lowerBound) &&
                    range.contains(matchLength) {
                    let start = urlString.index(urlString.startIndex, offsetBy: matchRange.lowerBound)
                    let end = urlString.index(urlString.startIndex, offsetBy: matchLength)
                    return String(urlString[start...end])
                }
            }
        } catch {
            print(error.localizedDescription)
        }

        return nil

    }

}
