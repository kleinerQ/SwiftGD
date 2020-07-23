#if canImport(Darwin)
import Darwin
import Cgdmac
#else
import Glibc
import Cgdlinux
#endif

import Foundation


public struct Color {
    public var red: Double
    public var green: Double
    public var blue: Double
    public var alpha: Double

    public init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

let image = gdImageCreateTrueColor(800, 600)


public class Image {
    // storage for our internal GD memory
    private var internalImage: gdImagePtr

    public init(width: Int, height: Int) {
        // convert the integer types, then stash away GD's resulting image data
        internalImage = gdImageCreateTrueColor(Int32(width), Int32(height))
    }

    deinit {
        // when this object is being destroyed, free its GD memory automatically
        gdImageDestroy(internalImage)
    }
    
    public func fill(_ color: Color) {
        let red = Int32(color.red * 255.0)
        let green = Int32(color.green * 255.0)
        let blue = Int32(color.blue * 255.0)

        // flip the alpha so that 1.0 becomes "fully opaque"
        let alpha = 127 - Int32(color.alpha * 127.0)

        let internalColor = gdImageColorAllocateAlpha(internalImage, red, green, blue, alpha)
        defer { gdImageColorDeallocate(internalImage, internalColor) }

        gdImageFill(internalImage, 0, 0, internalColor)
    }
    
    public func fillEllipse(center: CGPoint, size: CGSize, color: Color) {
        let red = Int32(color.red * 255.0)
        let green = Int32(color.green * 255.0)
        let blue = Int32(color.blue * 255.0)
        let alpha = 127 - Int32(color.alpha * 127.0)

        let internalColor = gdImageColorAllocateAlpha(internalImage, red, green, blue, alpha)
        defer { gdImageColorDeallocate(internalImage, internalColor) }

        gdImageFilledEllipse(internalImage, Int32(center.x), Int32(center.y), Int32(size.width), Int32(size.height), internalColor)
    }
    
    public func write() {
        let outputFile = fopen("output.png", "wb")
        defer { fclose(outputFile) }
        gdImagePng(internalImage, outputFile)
    }
}
