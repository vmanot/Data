//
// Copyright (c) Vatsal Manot
//

import Combine
import Compute
import Concurrency
import Swallow

public protocol RecordDatabase: Database {
    associatedtype Record: DatabaseRecord

    associatedtype RecordCreateProducer: Publisher where RecordCreateProducer.Output == Record
    associatedtype RecordFetchProducer: Publisher where RecordFetchProducer.Output == Record
    associatedtype RecordSaveProducer: Publisher where RecordSaveProducer.Output == Record
    associatedtype RecordUpdateProducer: Publisher where RecordUpdateProducer.Output == Record
    associatedtype RecordDeleteProducer: Publisher where RecordDeleteProducer.Output == Void
    associatedtype RecordListenProducer: Publisher where RecordListenProducer.Output == Record?

    func createRecord(with data: Record.Data, type: Record.`Type`) -> RecordCreateProducer
    func updateRecord(_ record: Record, with data: Record.Data) -> RecordUpdateProducer
    func deleteRecord(_ record: Record) -> RecordDeleteProducer
}

public protocol IdentifiableRecordDatabase: RecordDatabase where Record: IdentifiableDatabaseRecord {
    func createRecord(with _: Record.Identifier, type: Record.`Type`, data: Record.Data) -> RecordCreateProducer
    func fetchRecord(with _: Record.Identifier) -> RecordFetchProducer
    func saveRecord(_: Record) -> RecordSaveProducer
    func updateRecord(with identifier: Record.Identifier, context: Record.Context, data: Record.Data) -> RecordUpdateProducer
    func deleteRecord(with _: Record.Identifier) -> RecordDeleteProducer
    func listenToRecord(with _: Record.Identifier) -> RecordListenProducer
}
