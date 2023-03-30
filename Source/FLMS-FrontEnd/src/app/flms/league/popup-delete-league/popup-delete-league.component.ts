import { Component, OnInit, Inject } from '@angular/core';
import { CommonService } from '../../../common/common/common.service';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { first } from 'rxjs/operators';
import { LeagueService } from '../league.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-popup-delete-league',
  templateUrl: './popup-delete-league.component.html',
  styleUrls: ['./popup-delete-league.component.scss']
})
export class PopupDeleteLeagueComponent implements OnInit {
  loading = false;

  constructor(
    private commonService: CommonService,
    private leagueService: LeagueService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<PopupDeleteLeagueComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leagueId: number;
    },
    private router: Router,
  ) { }

  ngOnInit(): void {
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  onSubmit() {
    // stop here if form is invalid
    this.loading = true;
    this.leagueService.deleteLeague(this.data.leagueId)
      .pipe(first())
      .subscribe({
        next: () => {
          this.dialogRef.close();
          this.commonService.sendMessage('Delete league success!', 'success');
          this.router.navigate(['manager/my-league'])
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      });
  }
}
