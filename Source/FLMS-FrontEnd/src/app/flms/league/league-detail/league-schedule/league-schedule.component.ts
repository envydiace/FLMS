import { Component, OnInit } from '@angular/core';
import { MatchSchedule } from '../../../../models/match-schedule.model';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';
import { MatchScheduleResponse } from '../../../../models/match-schedule-response.model';
import { ActivatedRoute, Router } from '@angular/router';

import { PopUpEditMatchInfoComponent } from 'src/app/flms/match/match-detail/pop-up-edit-match-info/pop-up-edit-match-info.component';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ConfirmIsFinishComponent } from '../../pop-up-confirm-is-finish/pop-up-confirm-is-finish.component';
import { CommonService } from 'src/app/common/common/common.service';
import { AuthService } from 'src/app/auth/auth.service';

@Component({
  selector: 'app-league-schedule',
  templateUrl: './league-schedule.component.html',
  styleUrls: ['./league-schedule.component.scss']
})
export class LeagueScheduleComponent implements OnInit {
 
  displayedColumns: string[] = ['time', 'date', 'home', 'vs', 'away', 'group', 'stadium', 'action'];
  displayedColumnsC: string[] = ['time', 'date', 'home', 'vs', 'away', 'group', 'stadium'];
  leagueId: number;
  matchId: number;
  listMatch: MatchSchedule[] = [];
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  userRole: any;

  
  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    private commnonService: CommonService,
    private router: Router,
    public dialog: MatDialog,
    public authen: AuthService,
  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
    this.userRole = this.authen.getUserRole();
  }

  initDataSource() {
    this.LeagueService.getmatch(this.leagueId).pipe(
      map((res: MatchScheduleResponse) => this.listMatch = res.listMatch)
    ).subscribe();
  }

  navigateToMatchDetail(id: number) {
    this.router.navigate(['/manager/match-detail'], { queryParams: { matchId: id } });
  }

  openEditMatchInfo(matchId: number): void {
    const dialogRef = this.dialog.open(PopUpEditMatchInfoComponent, {
      width: '50%',
      data: { matchId: matchId }
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

  exportLeagueSchedule() {
    this.LeagueService.exportLeagueSchedule(this.leagueId).subscribe(res => {
      this.commnonService.downLoadFile(res, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      // this.downLoadFile(res, 'application/octet-stream');
    });
  }
}
