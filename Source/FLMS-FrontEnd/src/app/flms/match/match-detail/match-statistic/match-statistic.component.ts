import { Component, OnInit , Input } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute } from '@angular/router';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatchService } from './../../match.service';
import { ClubStats, MatchStats } from '../../../../models/match-statistics.model';
import { MatchStatisticsResponse } from '../../../../models/match-statistic-response.model';
import { PopUpEditMatchStatsComponent } from '../../pop-up-edit-match-stats/pop-up-edit-match-stats.component';
import { AuthService } from 'src/app/auth/auth.service';
@Component({
  selector: 'app-match-statistic',
  templateUrl: './match-statistic.component.html',
  styleUrls: ['./match-statistic.component.scss']
})
export class MatchStatisticComponent implements OnInit {
  matchStats: MatchStats;
  matchId: number;
  home: ClubStats;
  away: ClubStats;
  userRole: any;

  ELEMENT_DATA: PeriodicElement[] = [
    { home: 0, percentHome: 0, type: 'Shots', percentAway: 0, away: 0 },
    { home: 0, percentHome: 0, type: 'Shots On Target', percentAway: 0, away: 0 },
    { home: 0, percentHome: 0, type: 'Conner', percentAway: 0, away: 0 },
    { home: 0, percentHome: 0, type: 'Foul', percentAway: 0, away: 0 },
    { home: 0, percentHome: 0, type: 'Offside', percentAway: 0, away: 0 },
    { home: 0, percentHome: 0, type: 'Yellow Card', percentAway: 0, away: 0 },
    { home: 0, percentHome: 0, type: 'Red Card', percentAway: 0, away: 0 }
  ];

  displayedColumns: string[] = ['home', 'percentHome', 'type', 'percentAway', 'away'];
  dataSource = this.ELEMENT_DATA;

  constructor(
    private MatchService: MatchService,
    private route: ActivatedRoute,
    public dialog: MatDialog,
    public authen: AuthService,

  ) {
    this.route.queryParams.subscribe(params => {
      this.matchId = params['matchId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
    this.userRole = this.authen.getUserRole();

  }

  initDataSource() {
    this.MatchService.getMatchStatsById(this.matchId).pipe(map((res: MatchStatisticsResponse) => {
      this.home = res.home,
      this.away = res.away
    })).subscribe(() => {
      this.bindDataIntoHome(this.home);
      this.bindDataIntoAway(this.away);
      this.calculatePercentage();
    });
  }

  bindDataIntoHome (home: ClubStats) {
    this.ELEMENT_DATA[0].home = home.shot;
    this.ELEMENT_DATA[1].home = home.shotOnTarget;
    this.ELEMENT_DATA[2].home = home.conner;
    this.ELEMENT_DATA[3].home = home.foul;
    this.ELEMENT_DATA[4].home = home.offside;
    this.ELEMENT_DATA[5].home = home.yellowCard;
    this.ELEMENT_DATA[6].home = home.redCard;
  }

  bindDataIntoAway (away: ClubStats) {
    this.ELEMENT_DATA[0].away = away.shot;
    this.ELEMENT_DATA[1].away = away.shotOnTarget;
    this.ELEMENT_DATA[2].away = away.conner;
    this.ELEMENT_DATA[3].away = away.foul;
    this.ELEMENT_DATA[4].away = away.offside;
    this.ELEMENT_DATA[5].away = away.yellowCard;
    this.ELEMENT_DATA[6].away = away.redCard;
  }

  calculatePercentage() {
    for (let index = 0; index < 7; index++) {
      let sum = this.ELEMENT_DATA[index].home + this.ELEMENT_DATA[index].away;
      if (sum == 0) {
        this.ELEMENT_DATA[index].home = 0;
        this.ELEMENT_DATA[index].away = 0;
      } else {
        this.ELEMENT_DATA[index].percentHome = this.ELEMENT_DATA[index].home / sum * 100;
        this.ELEMENT_DATA[index].percentAway = this.ELEMENT_DATA[index].away / sum * 100;
      }
    }
  }

  openDialogUpdateStats(): void {
    const dialogRef = this.dialog.open(PopUpEditMatchStatsComponent, {
      width: '100%',
      data: { matchId: this.matchId }
    });

    dialogRef.afterClosed().subscribe(result => {
      this.ngOnInit();
      console.log('The dialog was closed');
    });
  }



}

export interface PeriodicElement {
  home: number;
  percentHome: number;
  type: string;
  percentAway: number;
  away: number;
}


