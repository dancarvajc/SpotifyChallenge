//
//  KeychainManager.swift
//  SpotifyChallenge
//
//  Created by Daniel Carvajal on 08-12-22.
//

import Foundation
import KeychainAccess


protocol KeychainManagerProtocol {
    func saveStringItem(_ item: String, key: String) throws
    func saveDataItem(_ item: Data, key: String) throws
    func getStringItem(key: String) throws -> String?
    func getDataItem(key: String) throws -> Data?
    func remove(key: String) throws
    func removeAll() throws
}

struct KeychainManager: KeychainManagerProtocol {
    
    private let keychain = Keychain(service: "SpotifyChallenge")
    
    func saveStringItem(_ item: String, key: String) throws {
        try keychain.set(item, key: key)
    }
    
    func saveDataItem(_ item: Data, key: String) throws {
        try keychain.set(item, key: key)
    }
    
    func getStringItem(key: String) throws -> String? {
        return try keychain.getString(key)
    }
    
    func getDataItem(key: String) throws -> Data? {
        return try keychain.getData(key)
    }
    
    func remove(key: String) throws {
        try keychain.remove(key)
    }
    
    func removeAll() throws {
        try keychain.removeAll()
    }
}

