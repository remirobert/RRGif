#!/usr/bin/swift -O

import AppKit
import Foundation
import CoreGraphics
import Foundation
import ImageIO

var arguments = Array<String>()
var images = Array<CGImage>()
var delayFrame: Float = 0.5
let path = NSProcessInfo.processInfo().environment["PWD"] as! String


arguments = Process.arguments
arguments.removeAtIndex(0)

func parseArguments() {
    let values = split(arguments, maxSplit: 100, allowEmptySlices: false, isSeparator: {$0.hasPrefix("-")})
    let options = split(arguments, maxSplit: 10, allowEmptySlices: false, isSeparator: {!$0.hasPrefix("-")})
    
    for (index, opt) in enumerate(Array(options)) {
        switch opt.first! {
        case "--images", "-i":
            Array(values[index]).map {imgName -> Void in
                if let image = NSImage(byReferencingFile: imgName),
                    let dataImage = image.TIFFRepresentation,
                    let source = CGImageSourceCreateWithData(dataImage, nil),
                    let maskRef = CGImageSourceCreateImageAtIndex(source, 0, nil) {
                        images.append(maskRef)
                }
                else {
                    fatalError("Error with image source : \(imgName)")
                }
            }
        case "--delay", "-d":
            if let delay = values[index].first {
                delayFrame = (delay as NSString).floatValue
            }
        default: break
        }
    }
}

func makeGif() {
    let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: delayFrame]]
    
    let gifProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyColorModel as String: kCGImagePropertyColorModelRGB, kCGImagePropertyGIFHasGlobalColorMap as String: true ]]
    let destinationPath = NSURL(fileURLWithPath: "\(path)/test.gif")
    let destination: CGImageDestination = CGImageDestinationCreateWithURL(destinationPath, kUTTypeGIF, images.count, Dictionary<String, String>())!
    for image in images {
        print("current traitement image : \(image)")
        CGImageDestinationAddImage(destination, image, frameProperties);
    }
    CGImageDestinationSetProperties(destination, gifProperties);
    CGImageDestinationFinalize(destination);
    println("Done [\(path)/test.gif]")
}

parseArguments()
if images.count > 0 {
    println("make gif")
    makeGif()
}
