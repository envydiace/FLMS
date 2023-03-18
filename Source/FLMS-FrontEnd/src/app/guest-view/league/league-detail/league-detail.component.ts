import { Component, Input, OnInit } from '@angular/core';
import { map } from 'rxjs/operators';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { LeagueDetail } from 'src/app/models/league-detail.model';
import { LeagueService } from '../league.service';
import { PopUpSendRegistrationComponent } from './pop-up-send-registration/pop-up-send-registration.component';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-league-detail',
  templateUrl: './league-detail.component.html',
  styleUrls: ['./league-detail.component.scss']
})
export class LeagueDetailComponent implements OnInit {
  leagueDetail: LeagueDetail= null;
  leagueId: number;

  constructor(
    private LeagueService: LeagueService,
    private route: ActivatedRoute,
    public dialog: MatDialog
  ) { 
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.LeagueService.getLeagueInfo(this.leagueId).pipe(
      map((res: LeagueDetailResponse) => this.leagueDetail = res.leagueInfo)
    ).subscribe();
  }


  openSendRegistation(): void{
    const dialogRef = this.dialog.open(PopUpSendRegistrationComponent, {
      width: '100%',
      data: { leagueId: this.leagueId}
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }
}
