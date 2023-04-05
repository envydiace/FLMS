import { Component, OnInit } from '@angular/core';
import { MatchSchedule } from 'src/app/models/match-schedule.model';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';
import { MatchScheduleResponse } from 'src/app/models/match-schedule-response.model';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonService } from 'src/app/common/common/common.service';

@Component({
  selector: 'app-league-schedule',
  templateUrl: './league-schedule.component.html',
  styleUrls: ['./league-schedule.component.scss']
})
export class LeagueScheduleComponent implements OnInit {
  displayedColumns: string[] = ['time', 'date', 'home', 'vs', 'away', 'group', 'stadium'];
  leagueId: number;
  listMatch: MatchSchedule[] = [];
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    private commnonService: CommonService,
    private router: Router
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

  exportLeagueSchedule() {
    this.LeagueService.exportLeagueSchedule(this.leagueId).subscribe(res => {
      this.commnonService.downLoadFile(res, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      // this.downLoadFile(res, 'application/octet-stream');
    });
  }

  navigateToMatchDetail(id: number) {
    this.router.navigate(['/match-info'], { queryParams: { matchId: id } });
  }
}
