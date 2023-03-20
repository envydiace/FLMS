import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';
import { LeagueStatisticResponse } from './../../../../models/league-statistics-response-model';
import { LeagueStanding, TopAssist, TopScorer } from 'src/app/models/league-statistics-model';

@Component({
  selector: 'app-league-statistic',
  templateUrl: './league-statistic.component.html',
  styleUrls: ['./league-statistic.component.scss']
})
export class LeagueStatisticComponent implements OnInit {

  displayLeagueStandingColumns: string[] = ['No', 'Team', 'Matches', 'W-D-L', '+/-', 'Points', 'History'];
  displayTopPlayer: string[] = ['No', 'Player', 'Record'];
  @Input() leagueId: number;
  leagueStanding: LeagueStanding[];
  topScorer: TopScorer[];
  topAssist: TopAssist[];

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    private router: Router,
  ) { }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.getLeagueService();
  }

  getLeagueService() {
    this.LeagueService.getLeagueStatistics(this.leagueId).pipe(
      map((res: LeagueStatisticResponse) => {
        this.leagueStanding = res.leagueStanding,
          this.topScorer = res.topScore,
          this.topAssist = res.topAssist
      })).subscribe();
  }
}
