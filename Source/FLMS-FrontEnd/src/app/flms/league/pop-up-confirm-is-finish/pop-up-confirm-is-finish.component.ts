import { Component, Inject, OnInit } from '@angular/core';
import { CommonService } from '../../../common/common/common.service';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { first } from 'rxjs/operators';
import { LeagueService } from '../league.service';

@Component({
  selector: 'app-confirm-is-finish',
  templateUrl: './pop-up-confirm-is-finish.component.html',
  styleUrls: ['./pop-up-confirm-is-finish.component.scss']
})
export class ConfirmIsFinishComponent implements OnInit {

  loading = false;
  constructor(
    private commonService: CommonService,
    private leagueService: LeagueService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<ConfirmIsFinishComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      matchId: number;
    }
  ) {

  }

  ngOnInit(): void {
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  onSubmit() {
   // stop here if form is invalid

    this.loading = true;
    this.leagueService.finishMatchConfirm(this.data.matchId)
      .pipe(first())
      .subscribe({
        next: () => {
          this.dialogRef.close();
          this.commonService.sendMessage('Confirmed Match is finished!','success')
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage('Something wrong happened!','fail')
        }
      });
  }
}
