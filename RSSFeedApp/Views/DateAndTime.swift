//
//  DateAndTime.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 13/12/2020.
//

import UIKit

class DateAndTime: UIStackView
{
    @IBOutlet weak var time: UILabel!
    
    var everyMinuteTimer: Timer?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetUp()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetUp()
    }

    func xibSetUp() {
        let view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView
    {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DateAndTime", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.everyMinuteTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        self.everyMinuteTimer?.fire()
    }
    
    deinit
    {
        self.everyMinuteTimer?.invalidate()
        self.everyMinuteTimer = nil
    }
}

extension DateAndTime
{
    @objc private func updateLabel()
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"

        self.time.text = dateFormatterGet.string(from: Date())
    }
}
