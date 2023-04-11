//
//  EmojiKeyboardStyle.swift
//  
//
//  Created by Abdullah Ansari on 01/09/22.
//

import UIKit

public final class EmojiKeyboardStyle: BaseStyle {
    
    private(set) var sectionHeaderFont = CometChatTheme.typography.text3
    private(set) var sectionHeaderColor = CometChatTheme.palatte.accent600
    private(set) var categoryIconTint = CometChatTheme.palatte.accent600
    private(set) var selectedCategoryIconTint = CometChatTheme.palatte.primary
    private(set) var titleColor = CometChatTheme.palatte.accent
    private(set) var titleFont = CometChatTheme.typography.title2
    private(set) var cancelButtonTint = CometChatTheme.palatte.primary
    
    @discardableResult
    public func set(sectionHeaderFont: UIFont) -> Self {
        self.sectionHeaderFont = sectionHeaderFont
        return self
    }
    
    @discardableResult
    public func set(sectionHeaderColor: UIColor) -> Self {
        self.sectionHeaderColor = sectionHeaderColor
        return self
    }
    
    @discardableResult
    public func set(categoryIconTint: UIColor) -> Self {
        self.categoryIconTint = categoryIconTint
        return self
    }
    
    @discardableResult
    public func set(selectedCategoryIconTint: UIColor) -> Self {
        self.selectedCategoryIconTint = selectedCategoryIconTint
        return self
    }
    
    @discardableResult
    public func set(titleColor: UIColor) -> Self {
        self.titleColor = titleColor
        return self
    }
    
    @discardableResult
    public func set(titleFont: UIFont) -> Self {
        self.titleFont = titleFont
        return self
    }
    
    @discardableResult
    public func set(cancelButtonTint: UIColor) -> Self {
        self.cancelButtonTint = cancelButtonTint
        return self
    }
    
}
