import UIKit
import QuartzCore
import OpenGLES
import GLKit
import CoreGraphics;

class GLCube: GLKView {
    var curRed: Float = 0
    var increasing: Bool = true

//    let displayLink: CADisplayLink

    var id: GLuint = 0;
    var imgSize: CGRect;
    var imagedata: UnsafeMutableRawPointer;

    override init(frame: CGRect, context: EAGLContext) {
        guard let image = UIImage(named: "texture") else {
            fatalError("no image")
        }

        let width = image.cgImage!.width;
        let height = image.cgImage!.height;

        imagedata = malloc(height * width * 4)

        let imgContext = CGContext(
            data: imagedata,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 4 * width,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        );

        imgSize = CGRect(origin: .zero, size: image.size);

        imgContext?.setBlendMode(CGBlendMode.copy)
        imgContext?.clear(imgSize)
        imgContext?.draw(image.cgImage!, in: imgSize)

        super.init(frame: frame, context: context)

//        let displayLink = CADisplayLink(target: self, selector: #selector(self.render(_:)))
//        displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)

        self.drawableColorFormat = .RGBA8888
        self.drawableDepthFormat = .format24
        self.drawableStencilFormat = .format8
        self.drawableMultisample = .multisample4X
    }

    deinit {
        glDeleteTextures(1, &id)
    }

    override func draw(_ rect: CGRect) {
        //        print("Im drawing")
        //        return;
        glClearColor(50, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))

        glGenTextures(1, &id);

        glBindTexture(GLenum(GL_TEXTURE_2D), id);

        glTexImage2D(
            GLenum(GL_TEXTURE_2D),
            GLint(0),
            GL_RGBA,
            GLsizei(imgSize.width),
            GLsizei(imgSize.height),
            GLint(0),
            GLenum(GL_RGBA),
            GLenum(GL_UNSIGNED_BYTE),
            &imagedata
        );

        glBindTexture(GLenum(GL_TEXTURE_2D), 0)

        if increasing {
            curRed += 0.01
        } else {
            curRed -= 0.01
        }

        if curRed >= 1.0 {
            curRed = 1.0
            increasing = false
        }

        if curRed <= 0.0 {
            curRed = 0.0
            increasing = true
        }

        glClearColor(curRed, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }

    override func display() {
        super.display()
    }

    @objc func render(_ displayLink: CADisplayLink) {
        self.display()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
