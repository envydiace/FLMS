import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialog, MatDialogRef } from '@angular/material/dialog';
import { LeagueService } from '../league.service';
import { Club } from 'src/app/models/match-schedule.model';
import { PopUpConfirmEditLeagueComponent } from '../league-detail/pop-up-confirm-edit-league/pop-up-confirm-edit-league.component';
import { first } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';

@Component({
  selector: 'app-pop-up-choose-losing-team',
  templateUrl: './pop-up-choose-losing-team.component.html',
  styleUrls: ['./pop-up-choose-losing-team.component.scss']
})
export class PopUpChooseLosingTeamComponent implements OnInit {

  defaultLogo: string = './../../../../assets/image/default-logo.png';
  conStatus = false;


  constructor(
    private leagueService: LeagueService,
    private commonService: CommonService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<PopUpChooseLosingTeamComponent>,
    public dialog: MatDialog,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      matchId: number;
      club1: Club;
      club2: Club;
    }
  ) {

   }

  ngOnInit(): void {
  }
  onNoClick(): void {
    this.dialogRef.close();
  }

  openConfirm(clubid:number): void {
    const dialogRef = this.dialog.open(PopUpConfirmEditLeagueComponent, {
      width: '30%',
      data: {  },
      disableClose: true
    });
    dialogRef.afterClosed().subscribe(result => {
      this.conStatus=result;
      if(result ==true ){
        this.chosenLoseClub( clubid);
      }else{
        return;
      }
    });

  }

  chosenLoseClub(clubid:number){
    this.leagueService.loseJudge(this.data.matchId, clubid)
      .pipe(first())
      .subscribe({
        next: response => {
          this.dialogRef.close();
          this.commonService.sendMessage(response.message, 'success');
        },
        error: error => {
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      });


  }

}
