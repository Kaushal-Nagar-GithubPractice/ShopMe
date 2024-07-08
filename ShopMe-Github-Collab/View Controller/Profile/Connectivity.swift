//
//  File.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import Foundation
import Reachability

class Connectivity{
    
    static var reachability : Reachability! = nil
    
    static func IsOnline() -> Bool{
        
        var IsOnline = false
        
        do {
            reachability = try Reachability()
        } catch {
            print("Error in Variable")
        }
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            
            IsOnline = true
            
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            IsOnline = false
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        return IsOnline
    }
}
