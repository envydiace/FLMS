import { Component, OnInit } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute } from '@angular/router';
import { MatchService } from './../../match.service';
import { MatchStats } from '../../../../models/match-statistics-model';
import { MatchStatisticsResponse } from '../../../../models/match-statistic-response-model';
@Component({
  selector: 'app-match-statistic',
  templateUrl: './match-statistic.component.html',
  styleUrls: ['./match-statistic.component.scss']
})
export class MatchStatisticComponent implements OnInit {
  matchStats: MatchStats;
  matchId: number;
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
    this.MatchService.getMatchStatsById(this.matchId).pipe(map((res: MatchStatisticsResponse) => this.matchStats = res)).subscribe();
  }

  getMatchStatsById(matchId: number) {
    this.MatchService.getMatchStatsById(this.matchId).pipe(map((res: MatchStatisticsResponse) => this.matchStats = res)).subscribe();
  }
}
