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
      CREATE TABLE IF NOT EXISTS Prescriptions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        medicine TEXT,
        time TEXT,
        recurrence TEXT,
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
  
  func insertPrescription (prescription: Prescription) {
    let insertQuery = "INSERT INTO Prescriptions (medicine, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"
    var statement: OpaquePointer?
    
    if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
      sqlite3_bind_text(statement, 1, (prescription.medicine as NSString).utf8String, -1, nil)
      sqlite3_bind_text(statement, 2, (prescription.time as NSString).utf8String, -1, nil)
      sqlite3_bind_text(statement, 3, (prescription.recurrence as NSString).utf8String, -1, nil)
      sqlite3_bind_int(statement, 4, (prescription.takeNow ? 1 : 0))
      
      if sqlite3_step(statement) == SQLITE_DONE {
        print("Receita inserida com sucesso!")
      } else {
        print("Falha ao inserir receita na tabela")
      }
    } else {
      print("INSERT statement falhou")
    }
    
    sqlite3_finalize(statement)
  }
  
  func fetchPrescriptions () -> [Prescription] {
    let fetchQuery = "SELECT * FROM Prescriptions"
    var statement: OpaquePointer?
    var prescriptions: [Prescription] = []
    
    if sqlite3_prepare(db, fetchQuery, -1, &statement, nil) == SQLITE_OK {
      while sqlite3_step(statement) == SQLITE_ROW {
        let id = String(sqlite3_column_int(statement, 0))
        let medicine = String(cString: sqlite3_column_text(statement, 1))
        let time = String(cString: sqlite3_column_text(statement, 2))
        let recurrence = String(cString: sqlite3_column_text(statement, 3))
        let takeNow = sqlite3_column_int(statement, 4) == 1
        
        let prescription = Prescription(
          id: id,
          medicine: medicine,
          time: time,
          recurrence: recurrence,
          takeNow: takeNow
        )
        
        prescriptions.append(prescription)
      }
    } else {
      print("SELECT statement falhou")
    }
    
    sqlite3_finalize(statement)
    return prescriptions
  }
}
