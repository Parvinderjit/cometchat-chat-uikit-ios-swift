//
//  MessageReceiptUtils.swift
//  
//
//  Created by Abdullah Ansari on 17/11/22.
//

import Foundation
import CometChatPro


public enum ReceiptStatus {
    case inProgress
    case sent
    case delivered
    case failed
    case read
}

public struct MessageReceiptUtils {
    
    public static func get(receiptStatus message: BaseMessage) -> ReceiptStatus {
        if let metaData = message.metaData, let isError = metaData["error"] as? Bool, isError {
            return .failed
        }
        if message.readAt > 0 {
            return .read
        } else if message.deliveredAt > 0 {
            return .delivered
        } else if message.sentAt > 0 {
            return  .sent
        } else if message.sentAt == 0 {
            return .inProgress
        }
        return .failed
    }
    
}
