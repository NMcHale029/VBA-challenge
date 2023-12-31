Attribute VB_Name = "Module1"
Sub RunTickerForAllSheets()

Dim ws_num As Integer
Dim ws As Worksheet
ws_num = ThisWorkbook.Worksheets.Count

'Loop all sheets through both functions
For i = 1 To ws_num
    ThisWorkbook.Worksheets(i).Activate
    Call CreateTicker
    Call Functionality

Next i

End Sub

Sub CreateTicker()

Dim StartYear As Double
Dim EndYear As Double
Dim YearChange As Double
Dim PercentChange As Double
Dim TotalStockVolume As LongLong
Dim TickerRow As Integer
Dim DayVolume As LongLong

TickerRow = 2
StartYear = Cells(2, 3).Value
TotalStockVolume = 0

lastrow = Cells(Rows.Count, 1).End(xlUp).Row

Range("I1").Value = "Ticker"
Range("J1").Value = "Yearly Change"
Range("K1").Value = "Percent Change"
Range("L1").Value = "Total Stock Volume"

For i = 2 To lastrow
    If Cells(i, 1).Value <> Cells(i + 1, 1).Value Then
        'Populate the ticker
        Cells(TickerRow, 9).Value = Cells(i, 1).Value
        
        'Sets End Year, Calculate YearChange, Populate the Year Change
        EndYear = Cells(i, 6).Value
        YearChange = EndYear - StartYear
        Cells(TickerRow, 10).Value = YearChange
        
        'Conditional statements for coloring cells
        If YearChange > 0 Then
            Cells(TickerRow, 10).Interior.ColorIndex = 4
        ElseIf YearChange < 0 Then
            Cells(TickerRow, 10).Interior.ColorIndex = 3
        End If
        
        'Calculate PercentChange, Populate the Percent Change, Reset StartYear
        PercentChange = YearChange / StartYear
        Cells(TickerRow, 11).Value = PercentChange
        StartYear = Cells(i + 1, 3).Value
        
        'Calculate and Populate the Total Stock Volume
        DayVolume = Cells(i, 7).Value
        TotalStockVolume = TotalStockVolume + DayVolume
        Cells(TickerRow, 12).Value = TotalStockVolume
        
        'Reset Total Volume, Year Change, and advance the TickerRow
        TotalStockVolume = 0
        YearChange = 0
        TickerRow = TickerRow + 1
    
    Else
        DayVolume = Cells(i, 7).Value
        TotalStockVolume = TotalStockVolume + DayVolume


    End If
    Next i

End Sub

Sub Functionality()

lastrow = Cells(Rows.Count, 1).End(xlUp).Row

'Insert the titles to the functionality chart
Range("P1").Value = "Ticker"
Range("Q1").Value = "Value"
Range("O2").Value = "Greatest % Increase"
Range("O3").Value = "Greatest % Decrease"
Range("O4").Value = "Greatest Total Volume"

Dim GreatestIncrease As Double
Dim GreatestDecrease As Double
Dim GreatestVolume As LongLong

'Set the max, min, and greatest volume from the ticker
GreatestIncrease = WorksheetFunction.Max(Range("K2", "K3001"))
GreatestDecrease = WorksheetFunction.Min(Range("K2", "K3001"))
GreatestVolume = WorksheetFunction.Max(Range("L2", "L3001"))

Range("Q2").Value = GreatestIncrease
Range("Q3").Value = GreatestDecrease
Range("Q4").Value = GreatestVolume

For i = 2 To 3001:

    If Cells(i, 11).Value = GreatestIncrease Then
        Range("P2").Value = Cells(i, 9).Value

    ElseIf Cells(i, 11).Value = GreatestDecrease Then
        Range("P3").Value = Cells(i, 9).Value
    
    ElseIf Cells(i, 12) = GreatestVolume Then
        Range("P4").Value = Cells(i, 9).Value
    
    End If
    Next i
        
End Sub


     �   3  �  K  �  c  �  {    �    �  7  �  O  �  g	  �	  
    �  #  �  ;  �  S  �  k  �  �    *�B  C 	O&             (������7�                                