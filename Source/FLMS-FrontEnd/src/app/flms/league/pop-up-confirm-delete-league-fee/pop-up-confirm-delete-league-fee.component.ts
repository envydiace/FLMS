import { Component, Inject, OnInit } from '@angular/core';
import { CommonService } from 'src/app/common/common/common.service';
import { LeagueService } from '../league.service';
import { MAT_DIALOG_DATA, MatDialog, MatDialogRef } from '@angular/material/dialog';
import { first } from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { token } from 'src/app/models/token.model';

@Component({
  selector: 'app-pop-up-confirm-delete-league-fee',
  templateUrl: './pop-up-confirm-delete-league-fee.component.html',
  styleUrls: ['./pop-up-confirm-delete-league-fee.component.scss']
})
export class PopUpConfirmDeleteLeagueFeeComponent implements OnInit {
  loading = false;
  private headers: HttpHeaders;
  token: token;


  constructor(
    private commonService: CommonService,
    private leagueService: LeagueService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<PopUpConfirmDeleteLeagueFeeComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leagueFeeId: number;
    }
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

  }

  ngOnInit(): void {

  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  onSubmit() {
    // stop here if form is invalid

    this.loading = true;
    this.leagueService.removeLeagueFee(this.data.leagueFeeId)
      .pipe(first())
      .subscribe({
        next: response => {
          this.dialogRef.close();
          this.commonService.sendMessage(response.message, 'success');
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      });
  }

}
