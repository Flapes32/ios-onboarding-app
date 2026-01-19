import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static var appPrimary: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark
                ? UIColor(hex: "#6C63FF")
                : UIColor(hex: "#5B52E5")
        }
    }
    
    static var appBackground: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark
                ? UIColor.systemBackground
                : UIColor.white
        }
    }
    
    static var appText: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark
                ? UIColor.white
                : UIColor.black
        }
    }
    
    static var appSecondaryText: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark
                ? UIColor.lightGray
                : UIColor.darkGray
        }
    }
}
