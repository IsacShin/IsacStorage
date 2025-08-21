//
//  File.swift
//  IsacStorage
//
//  Created by shinisac on 8/21/25.
//

import Foundation
import CoreData

@MainActor
final public class IsacCoreDataManager {
    private let container: NSPersistentContainer
    private var context: NSManagedObjectContext { container.viewContext }
    
    public static func makeShared(modelName: String) -> IsacCoreDataManager {
        return IsacCoreDataManager(modelName: modelName)
    }
    
    private init(modelName: String) {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("CoreData 초기화 실패: \(error)")
            }
        }
    }
    
    // MARK: - Save
    private func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    // MARK: - Create
    public func insert<T: NSManagedObject>(_ object: T) {
        context.insert(object)
        save()
    }
    
    // MARK: - Read
    public func fetch<T: NSManagedObject>(
        _ type: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch \(T.self): \(error)")
            return []
        }
    }
    
    // MARK: - Delete
    public func delete<T: NSManagedObject>(_ object: T) {
        context.delete(object)
        save()
    }
    
    public func deleteAll<T: NSManagedObject>(_ objects: [T]) {
        for obj in objects {
            context.delete(obj)
        }
        save()
    }
}
