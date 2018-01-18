import UIKit

class CheckBoxView: UIView {
    fileprivate static let borderColor: UIColor = .black
    fileprivate static let borderWidth: CGFloat = 4
    fileprivate static let uncheckedColor: UIColor = UIColor.clear
    fileprivate static let checkedColor: UIColor = .green
    fileprivate static let tickColor: UIColor = .white
    fileprivate static let tickWidth: CGFloat = 2
    fileprivate var boxLayer = CAShapeLayer()
    fileprivate var tickLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = CheckBoxView.tickColor.cgColor
        layer.lineWidth = CheckBoxView.tickWidth
        layer.lineJoin = kCALineJoinRound
        layer.lineCap = kCALineCapRound
        return layer
    }()

    enum Status {
        case checked
        case unchecked

        var isResolved: Bool {
            if case .checked = self {
                return true
            }
            return false
        }
    }

    var status: Status = .unchecked {
        didSet {
            switch status {
            case .unchecked:
                setupForUnchecked()
            case .checked:
                setupForChecked()
            }
            updateLayers()
        }
    }

    /// Padding to be added around the checkbox. Default value is 0.
    /// Set a positive value if you want the checkbox to be smaller than the view size (inset)
    /// Set a negative value if you want the checkbox to be larger than the view size (offset)
    var padding: CGFloat = 0

    /// Action to be executed when user taps on the checkbox view
    var pressAction: ((CheckBoxView) -> Void)?

    fileprivate var boxBorderColor: UIColor? = CheckBoxView.borderColor
    fileprivate var boxBackgroundColor: UIColor = CheckBoxView.uncheckedColor
    fileprivate var tickStrokeEnd: CGFloat = 0

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        invalidateIntrinsicContentSize()
    }

    override func draw(_ rect: CGRect) {
        // Box
        let inset = padding + CheckBoxView.borderWidth/2
        let boxframe = rect.insetBy(dx: inset, dy: inset)
        let boxPath = UIBezierPath(roundedRect: boxframe, cornerRadius: CheckBoxView.borderWidth)
        boxLayer.frame = rect
        boxLayer.path = boxPath.cgPath

        // Tick
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let tickPaddingPerc: CGFloat = 0.5
        let tickWidth = (1 - tickPaddingPerc)*boxframe.width
        let tickHeight = 0.83*tickWidth
        let left = center.x - tickWidth/2
        let right = center.x + tickWidth/2
        let top = center.y - tickHeight/2
        let bottom = center.y + tickHeight/2
        let leftSegmentWidth = tickWidth/3
        let leftOriginX = left
        let leftOriginY: CGFloat = bottom - tickHeight/3
        let tickUnion = CGPoint(x: leftOriginX + leftSegmentWidth, y: bottom)
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: leftOriginX, y: leftOriginY))
        linePath.addLine(to: tickUnion)
        linePath.move(to: tickUnion)
        linePath.addLine(to: CGPoint(x: right, y: top))

        tickLayer.frame = boxLayer.bounds
        tickLayer.path = linePath.cgPath
        invalidateIntrinsicContentSize()
        updateLayers()
    }

    deinit {
        pressAction = nil
    }

    public func toggleStatus() {
        status = status == .checked ? .unchecked : .checked
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }
}

// MARK: - Private

fileprivate extension CheckBoxView {

    func initialSetup() {
        backgroundColor = UIColor.clear
        layer.addSublayer(boxLayer)
        layer.addSublayer(tickLayer)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didPressCheckBox))
        addGestureRecognizer(tapGesture)
    }

    func setupForUnchecked() {
        boxBorderColor = CheckBoxView.borderColor
        boxBackgroundColor = CheckBoxView.uncheckedColor
        tickStrokeEnd = 0
    }

    func setupForChecked() {
        boxBorderColor = CheckBoxView.checkedColor
        boxBackgroundColor = CheckBoxView.checkedColor
        tickStrokeEnd = 1
    }

    func updateLayers() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        boxLayer.strokeColor = boxBorderColor?.cgColor
        boxLayer.fillColor = boxBackgroundColor.cgColor
        tickLayer.strokeEnd = tickStrokeEnd
        CATransaction.commit()
    }

    @objc func didPressCheckBox() {
        pressAction?(self)
    }
}

