import Foundation
import SwiftUI

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarSubtitlePreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNavBarBackButtonPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct CustomNavBarMenuButtonPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}




extension View {
    
    func customNavigationTitle(_ title: String) -> some View {
        self.preference(
            key: CustomNavBarTitlePreferenceKey.self,
            value: title
        )
    }
    
    func customNavigationSubtitle(_ subtitle: String) -> some View {
        self.preference(
            key: CustomNavBarSubtitlePreferenceKey.self,
            value: subtitle
        )
    }
    
    func customNavigationBackButtonHidden(_ show: Bool) -> some View {
        self.preference(
            key: CustomNavBarBackButtonPreferenceKey.self,
            value: !show
        )
    }
    
    func customNavigationMenuButtonHidden(_ show: Bool) -> some View {
        self.preference(
            key: CustomNavBarMenuButtonPreferenceKey.self,
            value: !show
        )
    }
}
