import { Component, OnInit, Inject } from '@angular/core';
import { CommonService } from 'src/app/common/common/common.service';
import { LeagueService } from '../../league.service';
import { MAT_DIALOG_DATA, MatDialog, MatDialogRef } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { first } from 'rxjs/operators';

@Component({
  selector: 'app-pop-up-remove-joined-club',
  templateUrl: './pop-up-remove-joined-club.component.html',
  styleUrls: ['./pop-up-remove-joined-club.component.scss']
})
export class PopUpRemoveJoinedClubComponent implements OnInit {
  loading = false;




  constructor(
    private commonService: CommonService,
    private leagueService: LeagueService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<PopUpRemoveJoinedClubComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leagueId: number;
      clubId: number;
    },
    private router: Router,
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
    this.leagueService.removeJoinedClub(this.data.leagueId, this.data.clubId)
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
