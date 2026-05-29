//
//  FormDataRepository.swift
//  Loan
//
//  Created by JayaKoushik on 28/05/26.
//
import CoreData

final class FormDataRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func save(_ data: FormData) {
        let entity = FormDataEntity(context: context)
        entity.id = data.id
        entity.name = data.name
        entity.email = data.email
        entity.phone = data.phone
        entity.gender = data.gender
        entity.address = data.address
        entity.annualIncome = data.annualIncome
        entity.loanAmount = data.loanAmount
        entity.irdNumber = data.irdNumber
        entity.submittedAt = data.submittedAt
        saveContext()
    }

    func fetchAll() -> [FormData] {
        let request = FormDataEntity.fetchRequest()
        guard let results = try? context.fetch(request) else { return [] }

        return results.map { entity in
            FormData(
                id: entity.id ?? UUID(),
                name: entity.name ?? "",
                email: entity.email ?? "",
                phone: entity.phone ?? "",
                gender: entity.gender ?? "",
                address: entity.address ?? "",
                annualIncome: entity.annualIncome ?? "",
                loanAmount: entity.loanAmount ?? "",
                irdNumber: entity.irdNumber ?? "",
                submittedAt: entity.submittedAt ?? Date()
            )
        }
    }

    func deleteById(_ id: UUID) {
        let request = FormDataEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        if let results = try? context.fetch(request) {
            results.forEach { context.delete($0) }
            saveContext()
        }
    }

    func deleteAll() {
        let request = FormDataEntity.fetchRequest()
        if let results = try? context.fetch(request) {
            results.forEach { context.delete($0) }
            saveContext()
        }
    }

    private func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}

