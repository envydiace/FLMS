import { Component, OnInit } from '@angular/core';
import { map } from 'rxjs/operators';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { LeagueDetail } from 'src/app/models/league-detail.model';
import { LeagueService } from '../league.service';

@Component({
  selector: 'app-league-detail',
  templateUrl: './league-detail.component.html',
  styleUrls: ['./league-detail.component.scss']
})
export class LeagueDetailComponent implements OnInit {
  leagueDetail: LeagueDetail= null;

  constructor(
    private LeagueService: LeagueService
  ) { }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.LeagueService.getLeagueInfo(1).pipe(
      map((res: LeagueDetailResponse) => this.leagueDetail = res.leagueInfo)
    ).subscribe();
  }

}
