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
    static var IsOnline = false
    
    static func IsOnlineFunc(){

        do {
            Connectivity.reachability = try Reachability()
        } catch {
            print("Error in Variable")
        }
        
        Connectivity.reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            
            Connectivity.IsOnline = true
            
        }
        Connectivity.reachability.whenUnreachable = { _ in
            print("Not reachable")
            Connectivity.IsOnline = false
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        
    }
}
