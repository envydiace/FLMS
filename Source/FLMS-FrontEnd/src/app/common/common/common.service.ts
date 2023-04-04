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

  downLoadFile(data: any, type: string) {
    let blob = new Blob([data], { type: type });
    let url = window.URL.createObjectURL(blob);
    let pwa = window.open(url);
    if (!pwa || pwa.closed || typeof pwa.closed == 'undefined') {
      this.sendMessage('Please disable your Pop-up blocker and try again.', 'error');
    }
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
