import { Component, OnInit } from '@angular/core';
import { MatchSchedule } from '../../../../models/match-schedule.model';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';
import { MatchScheduleResponse } from '../../../../models/match-schedule-response.model';
import { ActivatedRoute, Router } from '@angular/router';

import { PopUpEditMatchInfoComponent } from 'src/app/flms/match/match-detail/pop-up-edit-match-info/pop-up-edit-match-info.component';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ConfirmIsFinishComponent } from '../../pop-up-confirm-is-finish/pop-up-confirm-is-finish.component';

@Component({
  selector: 'app-league-schedule',
  templateUrl: './league-schedule.component.html',
  styleUrls: ['./league-schedule.component.scss']
})
export class LeagueScheduleComponent implements OnInit {
  displayedColumns: string[] = ['time','date', 'home','vs', 'away', 'group','stadium', 'action'];
  leagueId: number ;
  matchId: number;
  listMatch: MatchSchedule[] = [];

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    private router: Router,
    public dialog: MatDialog,
  ) { 
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.LeagueService.getmatch(this.leagueId).pipe(
      map((res: MatchScheduleResponse) => this.listMatch = res.listMatch)
    ).subscribe();
  }

  navigateToMatchDetail(id: number) {
    this.router.navigate(['/manager/match-info'], { queryParams: {matchId : id}, skipLocationChange: true});
  }

  openEditMatchInfo(matchId: number): void{
    const dialogRef = this.dialog.open(PopUpEditMatchInfoComponent, {
      width: '50%',
      data: { matchId : matchId}
    });

    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      console.log('The dialog was closed');
    });
  }

  openDialogConfirmIsFinished(matchId: number): void {
    const dialogRef = this.dialog.open(ConfirmIsFinishComponent, {
      width: '50%',
      data: { matchId: matchId }
    });
    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }

}
