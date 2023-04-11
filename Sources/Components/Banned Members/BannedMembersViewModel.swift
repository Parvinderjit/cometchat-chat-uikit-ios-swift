//
//  CometChatBannedMembers2ViewModel.swift
//  
//
//  Created by admin on 22/11/22.
//

import Foundation
import CometChatPro

protocol BannedMembersViewModelProtocol {
  
    var bannedGroupMembers: [CometChatPro.GroupMember] { get set }
    var filteredBannedGroupMembers: [CometChatPro.GroupMember] { get set }
    var bannedGroupMembersRequestBuilder: CometChatPro.BannedGroupMembersRequest.BannedGroupMembersRequestBuilder? { get set }
    var selectedBannedMembers: [CometChatPro.GroupMember] { get set }
    var failure: ((CometChatPro.CometChatException) -> Void)? { get set }
    var group: CometChatPro.Group { get set }
    var row: Int { get set }
    
    func fetchBannedGroupMembers()
    func filterBannedGroupMembers(text: String)
    func unbanGroupMember(member: GroupMember)
}

open class BannedMembersViewModel: NSObject, BannedMembersViewModelProtocol {
  
    var group: CometChatPro.Group
    var isSearching: Bool = false
    var bannedGroupMembersRequestBuilder: CometChatPro.BannedGroupMembersRequest.BannedGroupMembersRequestBuilder?
    var selectedBannedMembers: [CometChatPro.GroupMember] = []
    var failure: ((CometChatPro.CometChatException) -> Void)?
    var reloadAtIndex: ((Int) -> Void)?
    var reload: (() -> Void)?
    private var bannedGroupMembersRequest:  BannedGroupMembersRequest?
    private var filterBannedMembersRequest: BannedGroupMembersRequest?
    var row: Int = -1 {
        didSet {
            reloadAtIndex?(row)
        }
    }
    
    var bannedGroupMembers: [CometChatPro.GroupMember] = [] {
        didSet {
            reload?()
        }
    }
    
    var filteredBannedGroupMembers: [CometChatPro.GroupMember] = [] {
        didSet {
            reload?()
        }
    }
    
    init(group: Group, bannedGroupMembersRequestBuilder: CometChatPro.BannedGroupMembersRequest.BannedGroupMembersRequestBuilder?) {
        self.group = group
        self.bannedGroupMembersRequestBuilder = bannedGroupMembersRequestBuilder ?? BannedMembersBuilder.getSharedBuilder(for: group)
        self.bannedGroupMembersRequest = self.bannedGroupMembersRequestBuilder?.build()
    }
    
    func fetchBannedGroupMembers() {
        guard let bannedMemberRequest = bannedGroupMembersRequest else { return }
        BannedMembersBuilder.fetchBannedGroupMembers(bannedGroupMembersRequest: bannedMemberRequest ) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let fetchedBannedMembers):
                this.bannedGroupMembers += fetchedBannedMembers
            case .failure(let error):
                this.failure?(error)
            }
        }
    }
    
     func filterBannedGroupMembers(text: String) {
        self.filteredBannedGroupMembers.removeAll()
        self.filterBannedMembersRequest = self.bannedGroupMembersRequestBuilder?.set(searchKeyword: text).build()
        guard let filterBannedMembersRequest = filterBannedMembersRequest else { return }
         BannedMembersBuilder.filterBannedGroupMembers(filterBannedMembersRequest: filterBannedMembersRequest) { [weak self]  result in
            guard let this = self else { return }
            switch result {
            case .success(let filteredBannedMembers):
                this.filteredBannedGroupMembers = filteredBannedMembers
            case .failure(let error):
                this.failure?(error)
            }
        }
    }
    
     func unbanGroupMember(member: GroupMember) {
         guard let uid = member.uid else { return }
         BannedMembersBuilder.unbanGroupMembers(uid: uid, guid: group.guid)  { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(_):
                this.remove(groupMember: member)
                if let loggedInUser = LoggedInUserInformation.getUser() {
                    CometChatGroupEvents.emitOnGroupMemberUnban(unbannedUserUser: member, unbannedUserGroup: this.group, unbannedBy: loggedInUser)
                }
            case.failure(let error):
                this.failure?(error)
            }
        }
    }
}

extension BannedMembersViewModel {
    
    @discardableResult
    public func clearList() -> Self {
        self.bannedGroupMembers.removeAll()
        return self
    }
    
    @discardableResult
    public func size() -> Int {
        return  bannedGroupMembers.count
    }
    
    @discardableResult
    public func add(groupMember: GroupMember) -> Self {
        self.bannedGroupMembers.append(groupMember)
        return self
    }
    
    @discardableResult
    public func update(groupMember: GroupMember) -> Self {
        if let index = bannedGroupMembers.firstIndex(of: groupMember) {
            self.bannedGroupMembers[index] = groupMember
        }
        return self
    }
    
    @discardableResult
    public func remove(groupMember: GroupMember) -> Self {
        if let index = bannedGroupMembers.firstIndex(of: groupMember) {
            self.bannedGroupMembers.remove(at: index)
        }
        return self
    }
}
