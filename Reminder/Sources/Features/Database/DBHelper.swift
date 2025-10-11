//
//  DBHelper.swift
//  Reminder
//
//  Created by Daniel Moura on 11/10/25.
//

import Foundation
import SQLite3

class DBHelper {
  static let shared = DBHelper()
  private var db: OpaquePointer?
  
  private init()  {
    openDatabase()
    createTable()
  }
  
  private func openDatabase() {
    let fileURL = try! FileManager.default
      .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      .appendingPathComponent("Reminder.sqlite")
    
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
      print("Erro ao abrir o banco de dados")
    }
  }
  
  private func createTable() {
    let createTableQuery = """
      CREATE TABLE IF NOT EXISTS Receipts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        medicine TEXT,
        recurrency TEXT,
        takeNow INTEGER
      );
      """
    
    var statement: OpaquePointer?
    if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
      if sqlite3_step(statement) == SQLITE_DONE {
        print("Tabela criada com sucesso")
      } else {
        print("Erro na criação da tabela")
      }
    } else {
      print("CreateTable statement não conseguiu executar")
    }
    sqlite3_finalize(statement)
  }
  
  func insertPrescription () {
    
  }
}
