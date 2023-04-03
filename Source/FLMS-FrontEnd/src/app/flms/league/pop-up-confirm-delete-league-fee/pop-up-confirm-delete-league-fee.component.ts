import { Component, Inject, OnInit } from '@angular/core';
import { CommonService } from 'src/app/common/common/common.service';
import { LeagueService } from '../league.service';
import { MAT_DIALOG_DATA, MatDialog, MatDialogRef } from '@angular/material/dialog';
import { first } from 'rxjs/operators';

@Component({
  selector: 'app-pop-up-confirm-delete-league-fee',
  templateUrl: './pop-up-confirm-delete-league-fee.component.html',
  styleUrls: ['./pop-up-confirm-delete-league-fee.component.scss']
})
export class PopUpConfirmDeleteLeagueFeeComponent implements OnInit {
  loading = false;

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
         next: () => {
           this.dialogRef.close();
           this.commonService.sendMessage('That league fee has been deleted!','success');
         },
         error: error => {
           this.loading = false;
           this.commonService.sendMessage(error.error.message,'fail');
         }
       });
   }

}
