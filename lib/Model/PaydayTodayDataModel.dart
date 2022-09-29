import 'package:flutter/material.dart';

class PayDayEmployeeInfoDataModel {
  late int? ID;
  late String? DateTimeIN;
  late String? EmployerID;
  late String? EmployeeID;
  late String? BorrowerID;
  late String? FirstName;
  late String? MiddleName;
  late String? LastName;
  late String? EmailAddress;
  late String? MobileNo;
  late String? BirthDate;
  late String? SalaryType;
  late String? SalaryDetails;
  late String? SalaryReleaseMethod;
  late String? PeriodDateFrom;
  late String? PeriodDateTo;
  late double? EarnWage;
  late double? AvailableEarnWage;
  late double? UsedEarnWage;
  late double? CreditLimit;
  late double? AvailableCredits;
  late double? UsedCredits;
  late String? BankID;
  late String? BankAccountNo;
  late String? BankAccountName;
  late String? ProfilePicURL;
  late String? Status;
  late String? Extra1;
  late String? Extra2;
  late String? Extra3;
  late String? Extra4;
  late String? Notes1;
  late String? Notes2;

  PayDayEmployeeInfoDataModel(
    this.ID, this.DateTimeIN, this.EmployerID, this.EmployeeID, this.BorrowerID, 
    this.FirstName, this.MiddleName, this.LastName, this.EmailAddress, this.MobileNo, 
    this.BirthDate, this.SalaryType, this.SalaryDetails, this.SalaryReleaseMethod, this.PeriodDateFrom, 
    this.PeriodDateTo, this.EarnWage, this.AvailableEarnWage, this.UsedEarnWage, this.CreditLimit, 
    this.AvailableCredits, this.UsedCredits, this.BankID, this.BankAccountNo, this.BankAccountName,
    this.ProfilePicURL, this.Status, this.Extra1, this.Extra2, this.Extra3,
    this.Extra4, this.Notes1, this.Notes2);

  factory PayDayEmployeeInfoDataModel.fromMap(Map<String, dynamic> data) {
    return PayDayEmployeeInfoDataModel( 
        data['ID'], data['DateTimeIN'], data['EmployerID'], data['EmployeeID'], data['BorrowerID'],
        data['FirstName'], data['MiddleName'], data['LastName'], data['EmailAddress'], data['MobileNo'], 
        data['BirthDate'], data['SalaryType'], data['SalaryDetails'], data['SalaryReleaseMethod'], data['PeriodDateFrom'],
        data['AvailableCredits'], data['EarnWage'], data['AvailableEarnWage'], data['UsedEarnWage'], data['CreditLimit'], 
        data['Extra3'], data['UsedCredits'], data['BankID'], data['BankAccountNo'], data['BankAccountName'],
        data['ProfilePicURL'], data['Status'], data['Extra1'], data['Extra2'], data['Extra3'],
        data['Extra4'], data['Notes1'], data['Notes2']
    ); 
  }
}

class PayDayTransactionHistoryDataModel {
  late int? ID;
  late String? DateTimeIN;
  late String? DateTimeCompleted;
  late String? ProcessID;
  late String? TransferProcessID;
  late String? VoucherProcessID;
  late String? TransactionNo;
  late String? LedgerTrxnNo;
  late String? EmployerID;
  late String? EmployeeID;
  late double? Amount;
  late double? ServiceFee;
  late double? TotalAmount;
  late String? Medium;
  late double? PreAvailableCredits;
  late double? PostAvailableCredits;
  late String? Status;
  late String? Remarks;
  late String? Extra1;
  late String? Extra2;
  late String? Extra3;
  late String? Extra4;
  late String? Notes1;
  late String? Notes2;

  PayDayTransactionHistoryDataModel(this.ID, this.DateTimeIN, this.DateTimeCompleted, this.ProcessID, this.TransferProcessID, 
                            this.VoucherProcessID, this.TransactionNo, this.LedgerTrxnNo, this.EmployerID, this.EmployeeID, 
                            this.Amount, this.ServiceFee, this.TotalAmount, this.Medium, this.PreAvailableCredits, 
                            this.PostAvailableCredits, this.Status, this.Remarks, this.Extra1, this.Extra2, 
                            this.Extra3, this.Extra4, this.Notes1, this.Notes2);

  factory PayDayTransactionHistoryDataModel.fromMap(Map<String, dynamic> data) {
    return PayDayTransactionHistoryDataModel( 
        data['ID'], data['DateTimeIN'], data['DateTimeCompleted'], data['ProcessID'], data['TransferProcessID'],
        data['VoucherProcessID'], data['TransactionNo'], data['LedgerTrxnNo'], data['EmployerID'], data['EmployeeID'], 
        data['Amount'], data['ServiceFee'], data['TotalAmount'], data['Medium'], data['PreAvailableCredits'],
        data['PostAvailableCredits'], data['Status'], data['Remarks'], data['Extra1'], data['Extra2'], 
        data['Extra3'], data['Extra4'], data['Notes1'], data['Notes2']
    ); 
  }
}

class PaydayCompanyListDataModel {
  late String? EmployeeID;
  late String? EmployerID;
  late String? GuarantorID;
  late String? CompanyName;
  late String? Notes2;

  PaydayCompanyListDataModel(this.EmployeeID, this.EmployerID, this.GuarantorID, this.CompanyName, this.Notes2);

  factory PaydayCompanyListDataModel.fromMap(Map<String, dynamic> data) {
    return PaydayCompanyListDataModel( 
      data['EmployeeID'], data['EmployerID'], data['GuarantorID'], data['CompanyName'], data['Notes2']
    ); 
  }
}


