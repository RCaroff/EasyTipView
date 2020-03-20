//
// ViewController.swift
//
// Copyright (c) 2015 Teodor Patraş
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import Darwin
import EasyTipView

class ViewController: UIViewController {

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tbItem: UITabBarItem!
    @IBOutlet weak var smallContainerView: UIView!
    @IBOutlet weak var navBarItem: UIBarButtonItem!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var buttonE: UIButton!
    @IBOutlet weak var buttonF: UIButton!
    @IBOutlet weak var buttonG: UIButton!
    @IBOutlet weak var buttonLambda: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    weak var tipView: EasyTipView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        
        var preferences = EasyTipView.Preferences()
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(white: 0, alpha: 0.2)
        preferences.drawing.backgroundOverlayEnabled = true
        preferences.drawing.backgroundOverlayOpacity = 0.6
        preferences.drawing.backgroundOverlayColor = .darkGray
        preferences.positioning.maxWidth = 300
        preferences.interacting.dismissMode = .outOfTheBox
        EasyTipView.globalPreferences = preferences
        setupFont()
        self.view.backgroundColor = UIColor(hue:0.75, saturation:0.01, brightness:0.96, alpha:1.00)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        barButtonAction(sender: navBarItem)

        toolbarItemAction()

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupFont()
    }
    
    func setupFont() {
        guard let dynamicFont = UIFont(name: "Futura-Medium", size: 13) else {
            fatalError("""
        Failed to load the "CustomFont-Light" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        
        if #available(iOS 11.0, *) {
            EasyTipView.globalPreferences.drawing.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: dynamicFont)
        } else {
            EasyTipView.globalPreferences.drawing.font = dynamicFont
        }
    }

    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        print("\(tipView) did dismiss!")
    }
    
    func easyTipView(tipview: EasyTipView, didTapOnHighlightedView view: UIView) {
        print("highlightedView tapped")
    }
    
    @IBAction func buttonLambdaAction() {
        var preferences = EasyTipView.globalPreferences
        preferences.drawing.backgroundOverlayEnabled = false
        preferences.drawing.backgroundColor = .systemYellow
        preferences.drawing.foregroundColor = UIColor.darkGray
        preferences.drawing.textAlignment = NSTextAlignment.center
        preferences.drawing.cornerRadius = 20

        EasyTipView.show(animated: true, forView: buttonLambda, text: "ça fonctionne bien !", preferences: preferences)
    }
    
    @IBAction func barButtonAction(sender: UIBarButtonItem) {
        let text = "Tip view for bar button item displayed within the navigation controller's view. Tap to dismiss."
        EasyTipView.show(forItem: self.navBarItem,
            withinSuperview: self.navigationController?.view,
            text: text)
    }
    
    @IBAction func toolbarItemAction() {
        if let tipView = tipView {
            tipView.dismiss(withCompletion: { 
                print("Completion called!")
            })
        } else {
            let text = "EasyTipView is an easy to use tooltip view. It can point to any UIView or UIBarItem subclasses. Tap the buttons to see other tooltips."
            
            var preferences = EasyTipView.globalPreferences
            preferences.drawing.shadowColor = UIColor.black
            preferences.drawing.shadowRadius = 2
            preferences.drawing.shadowOpacity = 0.75
            preferences.drawing.arrowPosition = .any
            let tip = EasyTipView(text: text, preferences: preferences)
            tip.show(animated: true, forItem: tbItem)
            tipView = tip
        }
    }
    
    @IBAction func buttonAction(sender : UIButton) {
        switch sender {
        case buttonA:
            
            var preferences = EasyTipView.Preferences()
            preferences.drawing.backgroundColor = UIColor(hue:0.58, saturation:0.1, brightness:1, alpha:1)
            preferences.drawing.foregroundColor = UIColor.darkGray
            preferences.drawing.textAlignment = NSTextAlignment.center
            
            preferences.animating.dismissTransform = CGAffineTransform(translationX: 100, y: 0)
            preferences.animating.showInitialTransform = CGAffineTransform(translationX: -100, y: 0)
            preferences.animating.showInitialAlpha = 0
            preferences.animating.showDuration = 0.3
            preferences.animating.dismissDuration = 0.3
            
            let view = EasyTipView(text: "Tip view within the green superview. Tap to dismiss.", preferences: preferences)
            view.show(forView: buttonA, withinSuperview: self.smallContainerView)
            
        case buttonB:
            
            var preferences = EasyTipView.globalPreferences
            preferences.drawing.foregroundColor = UIColor.white
            preferences.drawing.font = UIFont(name: "HelveticaNeue-Light", size: 14)!
            preferences.drawing.textAlignment = NSTextAlignment.justified
            
            preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
            preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: 15)
            preferences.animating.showInitialAlpha = 0
            preferences.animating.showDuration = 0.3
            preferences.animating.dismissDuration = 0.3
            preferences.drawing.arrowPosition = .top
            
            let text = "Tip view inside the navigation controller's view. Tap to dismiss!"
            EasyTipView.show(forView: self.buttonB,
                withinSuperview: self.navigationController?.view,
                text: text,
                preferences: preferences)
            
        case buttonC:
            
            var preferences = EasyTipView.globalPreferences
            preferences.drawing.backgroundColor = buttonC.backgroundColor!
            
            preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
            preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
            preferences.animating.showInitialAlpha = 0
            preferences.animating.showDuration = 0.3
            preferences.animating.dismissDuration = 0.3
            preferences.drawing.arrowPosition = .top
            
            let text = "This tip view cannot be presented with the arrow on the top position, so position bottom has been chosen instead. Tap to dismiss."
            EasyTipView.show(forView: buttonC,
                withinSuperview: navigationController?.view,
                text: text,
                preferences: preferences)
            
        case buttonE:
            
            var preferences = EasyTipView.Preferences()
            preferences.drawing.backgroundColor = buttonE.backgroundColor!
            preferences.drawing.foregroundColor = UIColor.white
            preferences.drawing.textAlignment = NSTextAlignment.center
            
            preferences.drawing.arrowPosition = .right
            
            preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: 100)
            preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -100)
            preferences.animating.showInitialAlpha = 0
            preferences.animating.showDuration = 0.3
            preferences.animating.dismissDuration = 0.3
            
            preferences.positioning.maxWidth = 150
            
            let view = EasyTipView(text: "Tip view positioned with the arrow on the right. Tap to dismiss.", preferences: preferences)
            view.show(forView: buttonE, withinSuperview: self.navigationController?.view!)
            
        case buttonF:
            
            var preferences = EasyTipView.Preferences()
            preferences.drawing.backgroundColor = buttonF.backgroundColor!
            preferences.drawing.foregroundColor = UIColor.white
            preferences.drawing.textAlignment = NSTextAlignment.center
            
            preferences.drawing.arrowPosition = .left
            
            preferences.animating.dismissTransform = CGAffineTransform(translationX: -30, y: -100)
            preferences.animating.showInitialTransform = CGAffineTransform(translationX: 30, y: 100)
            preferences.animating.showInitialAlpha = 0
            preferences.animating.showDuration = 0.3
            preferences.animating.dismissDuration = 0.3
            preferences.interacting.dismissMode = .outOfTheBox
            
            preferences.positioning.maxWidth = 150
            
            let view = EasyTipView(text: "Tip view positioned with the arrow on the left. Tap won't dismiss.", preferences: preferences)
            view.show(forView: buttonF, withinSuperview: self.navigationController?.view!)
            
        case buttonG:
            
            var preferences = EasyTipView.globalPreferences
            preferences.drawing.backgroundColor = buttonG.backgroundColor!

            preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
            preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: 15)
            preferences.animating.showInitialAlpha = 0
            preferences.animating.showDuration = 0.3
            preferences.animating.dismissDuration = 0.3
            preferences.drawing.arrowPosition = .bottom
            
            preferences.positioning.contentHInset = 5
            preferences.positioning.contentVInset = 5
            
            let contentView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 82))
            contentView.image = UIImage(named: "easytipview")
            EasyTipView.show(forView: self.buttonG,
                             contentView: contentView,
                             preferences: preferences)

        default:
            
            var preferences = EasyTipView.globalPreferences
            preferences.drawing.arrowPosition = .bottom
            preferences.drawing.font = UIFont.systemFont(ofSize: 14)
            preferences.drawing.textAlignment = .center
            preferences.drawing.backgroundColor = buttonD.backgroundColor!
            
            preferences.positioning.maxWidth = 130
            
            preferences.animating.dismissTransform = CGAffineTransform(translationX: 100, y: 0)
            preferences.animating.showInitialTransform = CGAffineTransform(translationX: 100, y: 0)
            preferences.animating.showInitialAlpha = 0
            preferences.animating.showDuration = 0.3
            preferences.animating.dismissDuration = 0.3
            
            EasyTipView.show(forView: self.buttonD,
                text: "Tip view within the topmost window. Tap to dismiss.",
                preferences: preferences)
        }
    }
    
    func  configureUI () {
        tabBar.unselectedItemTintColor = .systemYellow
        let color = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        
        buttonA.backgroundColor = UIColor(hue:0.58, saturation:0.1, brightness:1, alpha:1)
        
        self.navigationController?.view.tintColor = color
        
        self.buttonB.backgroundColor = color
        self.smallContainerView.backgroundColor = color
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = tableView.cellForRow(at: indexPath) else { return }
        EasyTipView.show(animated: true,
                         forView: row,
                         text: row.textLabel?.text ?? "")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        switch indexPath.row {
        case 0:
          cell.textLabel?.text = "Hello world"
        default:
          cell.textLabel?.text = "Goodbye world"
        }

        return cell
    }
}

extension ViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        toolbarItemAction()
    }
}
