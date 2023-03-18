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

  public sendMessage(msg: string, type: string) {
    if (type == 'success') {
      if (msg.trim() == null || msg.trim() == '') {
        msg = 'Success!';
      }
      this._snackBar.open(msg, 'Close', {
        duration: 5000,
        panelClass: ['green-snackbar'],
        horizontalPosition: 'right',
        verticalPosition: 'top',
      });
    } else if (type == 'fail') {
      if (msg.trim() == null || msg.trim() == '') {
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
}
