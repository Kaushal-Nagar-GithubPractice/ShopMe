//
//  ProductInCart+CoreDataProperties.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 04/07/24.
//
//

import Foundation
import CoreData


extension ProductInCart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductInCart> {
        return NSFetchRequest<ProductInCart>(entityName: "ProductInCart")
    }

    @NSManaged public var productId: String?
    @NSManaged public var size: String?
    @NSManaged public var color: String?

}

extension ProductInCart : Identifiable {

}
