import { Component, OnInit } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute } from '@angular/router';
import { MatchService } from './../../match.service';
import { ClubStats, MatchStats } from '../../../../models/match-statistics-model';
import { MatchStatisticsResponse } from '../../../../models/match-statistic-response-model';
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
    });
  }

  getMatchStatsById(matchId: number) {
    this.MatchService.getMatchStatsById(this.matchId).pipe(map((res: MatchStatisticsResponse) => this.matchStats = res)).subscribe();
  }

  bindDataIntoHome (home: ClubStats) {
    ELEMENT_DATA[0].home = home.shot;
  }

}

export interface PeriodicElement {
  home: number;
  type: string;
  away: number;
}

const ELEMENT_DATA: PeriodicElement[] = [
  {home: 0, type: 'Hydrogen', away: 0},
  {home: 0, type: 'Helium', away: 0},
  {home: 0, type: 'Lithium', away: 0},
  {home: 0, type: 'Beryllium', away: 0},
  {home: 0, type: 'Boron', away: 0},
  {home: 0, type: 'Carbon', away: 0},
  {home: 0, type: 'Nitrogen', away: 0},
  {home: 0, type: 'Oxygen', away: 0}
];
