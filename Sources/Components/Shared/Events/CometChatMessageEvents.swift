//
//  CometChatMessageEvents.swift
 
//
//  Created by Pushpsen Airekar on 13/05/22.
//

import UIKit
import CometChatSDK
import Foundation

public protocol CometChatMessageEventListener {
    func onMessageSent(message: BaseMessage, status: MessageStatus)
    func onMessageEdit(message: BaseMessage, status: MessageStatus)
    func onMessageDelete(message: BaseMessage)
    func onMessageReply(message: BaseMessage, status: MessageStatus)
    func onMessageRead(message: BaseMessage)
    func onParentMessageUpdate(message: BaseMessage)
    func onLiveReaction(reaction: TransientMessage)
    func onMessageError(error: CometChatException)
    func onVoiceCall(user: User)
    func onVoiceCall(group: Group)
    func onVideoCall(user: User)
    func onVideoCall(group: Group)
    func onViewInformation(user: User)
    func onViewInformation(group: Group)
    func onError(message: BaseMessage?, error: CometChatException)
    func onMessageReact(message: BaseMessage, reaction: CometChatMessageReaction)
}


public class CometChatMessageEvents {
    
    static private var observer = [String: CometChatMessageEventListener]()
    
     public static func addListener(_ id: String,_ observer: CometChatMessageEventListener) {
        self.observer[id] = observer
    }
    
     public static func removeListener(_ id: String) {
        self.observer.removeValue(forKey: id)
    }
    
    public static  func emitOnMessageSent(message: BaseMessage, status: MessageStatus) {
        print("self.observer: \(self.observer)")
        self.observer.forEach({
            (key,observer) in
            observer.onMessageSent(message: message, status: status)
        })
    }
    public static  func emitOnMessageEdit(message: BaseMessage, status: MessageStatus) {
        self.observer.forEach({
            (key,observer) in
            observer.onMessageEdit(message: message, status: status)
        })
    }
    public static  func emitOnMessageDelete(message: BaseMessage) {
        self.observer.forEach({
            (key,observer) in
            observer.onMessageDelete(message: message)
        })
    }
    public static  func emitOnMessageReply(message: BaseMessage, status: MessageStatus) {
        self.observer.forEach({
            (key,observer) in
            observer.onMessageReply(message: message, status: status)
        })
        
    }
    public static  func emitOnMessageRead(message: BaseMessage) {
        self.observer.forEach({
            (key,observer) in
            observer.onMessageRead(message: message)
        })
    }
    
    public static  func emitOnLiveReaction(reaction: TransientMessage) {
        self.observer.forEach({
            (key,observer) in
            observer.onLiveReaction(reaction: reaction)
        })
    }
    
    public static  func emitOnVoiceCall(user: User) {
        self.observer.forEach({
            (key,observer) in
            observer.onVoiceCall(user: user)
        })
    }
    public static  func emitOnVoiceCall(group: Group) {
        self.observer.forEach({
            (key,observer) in
            observer.onVoiceCall(group: group)
        })
    }
    public static  func emitOnVideoCall(user: User) {
        self.observer.forEach({
            (key,observer) in
            observer.onVideoCall(user: user)
        })
    }
    public static  func emitOnVideoCall(group: Group) {
        self.observer.forEach({
            (key,observer) in
            observer.onVideoCall(group: group)
        })
    }
    public static  func emitOnViewInformation(user: User) {
        self.observer.forEach({
            (key,observer) in
            observer.onViewInformation(user: user)
        })
    }
    public static  func emitOnViewInformation(group: Group) {
        self.observer.forEach({
            (key,observer) in
            observer.onViewInformation(group: group)
        })
    }
    public static  func emitOnError(message: BaseMessage?, error: CometChatException) {
        self.observer.forEach({
            (key,observer) in
            observer.onError(message: message, error: error)
        })
    }
    public static  func emitOnMessageReact(message: BaseMessage, reaction: CometChatMessageReaction) {
        self.observer.forEach({
            (key,observer) in
            observer.onMessageReact(message: message, reaction: reaction)
        })
    }
    
    public static  func emitOnParentMessageUpdate(message: BaseMessage) {
        self.observer.forEach({
            (key,observer) in
            observer.onParentMessageUpdate(message: message)
        })
    }
}
