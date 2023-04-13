import { Injectable } from '@angular/core';
import {
  MatSnackBar
} from '@angular/material/snack-bar';

@Injectable({
  providedIn: 'root'
})
export class CommonService {

  constructor(
    private _snackBar: MatSnackBar
  ) { }

  downLoadFile(data: any, type: string, fileName: string) {
    let blob = new Blob([data], { type: type });
    let url = window.URL.createObjectURL(blob);
    var anchor = document.createElement("a");
    anchor.download = fileName + '.xlsx';
    anchor.href = url;
    anchor.click();
  }

  public sendMessage(msg: string, type: string) {
    if (type == 'success') {
      if (msg == null || msg == '') {
        msg = 'Success!';
      }
      this._snackBar.open(msg, 'Close', {
        duration: 5000,
        panelClass: ['green-snackbar'],
        horizontalPosition: 'right',
        verticalPosition: 'top',
      });
    } else if (type == 'fail') {
      if (msg == null || msg == '') {
        msg = 'Something wrong!';
      }
      this._snackBar.open(msg, 'Close', {
        duration: 5000,
        panelClass: ['red-snackbar'],
        horizontalPosition: 'right',
        verticalPosition: 'top',
      });
    } else {
      this._snackBar.open(msg, 'Close', {
        duration: 5000,
        panelClass: ['blue-snackbar'],
        horizontalPosition: 'right',
        verticalPosition: 'top',
      });
    }
  }

  public addHoursToDate(date: Date): Date {
    const result = new Date(date);
    result.setHours(result.getHours() + 7);
    return result;
  }
}
