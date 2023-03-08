import { Component, OnInit } from '@angular/core';
import { MatchSchedule } from 'src/app/models/match-schedule.model';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';
import { MatchScheduleResponse } from 'src/app/models/match-schedule-response.model';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-league-schedule',
  templateUrl: './league-schedule.component.html',
  styleUrls: ['./league-schedule.component.scss']
})
export class LeagueScheduleComponent implements OnInit {
  displayedColumns: string[] = ['time', 'home','vs', 'away', 'group', 'action'];
  leagueId: number ;
  listMatch: MatchSchedule[] = [];

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService
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
}
