import { Component, OnInit , Input } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute } from '@angular/router';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatchService } from './../../match.service';
import { ClubStats, MatchStats } from '../../../../models/match-statistics-model';
import { MatchStatisticsResponse } from '../../../../models/match-statistic-response-model';
import { PopUpEditMatchStatsComponent } from '../../pop-up-edit-match-stats/pop-up-edit-match-stats.component';
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

  displayedColumns: string[] = ['home', 'type', 'away'];
  dataSource = ELEMENT_DATA;

  constructor(
    private MatchService: MatchService,
    private route: ActivatedRoute,
    public dialog: MatDialog,
  ) {
    this.route.queryParams.subscribe(params => {
      this.matchId = params['matchId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.MatchService.getMatchStatsById(this.matchId).pipe(map((res: MatchStatisticsResponse) => {
      this.home = res.home,
      this.away = res.away
    })).subscribe(() => {
      this.bindDataIntoHome(this.home);
      this.bindDataIntoAway(this.away);
    });
  }

  bindDataIntoHome (home: ClubStats) {
    ELEMENT_DATA[0].home = home.shot;
    ELEMENT_DATA[1].home = home.shotOnTarget;
    ELEMENT_DATA[2].home = home.conner;
    ELEMENT_DATA[3].home = home.foul;
    ELEMENT_DATA[4].home = home.offside;
    ELEMENT_DATA[5].home = home.yellowCard;
    ELEMENT_DATA[6].home = home.redCard;
  }

  bindDataIntoAway (away: ClubStats) {
    ELEMENT_DATA[0].away = away.shot;
    ELEMENT_DATA[1].away = away.shotOnTarget;
    ELEMENT_DATA[2].away = away.conner;
    ELEMENT_DATA[3].away = away.foul;
    ELEMENT_DATA[4].away = away.offside;
    ELEMENT_DATA[5].away = away.yellowCard;
    ELEMENT_DATA[6].away = away.redCard;
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
  type: string;
  away: number;
}

const ELEMENT_DATA: PeriodicElement[] = [
  {home: 0, type: 'Shots', away: 0},
  {home: 0, type: 'Shots On Target', away: 0},
  {home: 0, type: 'Conner', away: 0},
  {home: 0, type: 'Foul', away: 0},
  {home: 0, type: 'Offside', away: 0},
  {home: 0, type: 'Yellow Card', away: 0},
  {home: 0, type: 'Red Card', away: 0}
];


