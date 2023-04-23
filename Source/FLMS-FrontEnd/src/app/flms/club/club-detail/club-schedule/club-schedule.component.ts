import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ClubMatchSchedule } from './../../../../models/match-schedule.model';
import { ClubService } from '../../club.service';
import { map, tap } from 'rxjs/operators';
import { ClubMatchScheduleResponse } from './../../../../models/match-schedule-response.model';

@Component({
  selector: 'app-club-schedule',
  templateUrl: './club-schedule.component.html',
  styleUrls: ['./club-schedule.component.scss']
})
export class ClubScheduleComponent implements OnInit {

  displayedColumns: string[] = ['leagueName','matchDate', 'matchTime', 'against', 'round', 'stadium', 'ha'];
  clubId: number;
  listMatch: ClubMatchSchedule[] = []
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';

  constructor(
    private route: ActivatedRoute,
    private ClubService: ClubService
  ) {
    this.route.queryParams.subscribe(params => {
      this.clubId = params['clubId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }
  initDataSource() {
    this.ClubService.getClubMatch(this.clubId).pipe(
      map((res: ClubMatchScheduleResponse) => this.listMatch = res.listMatch)
    ).subscribe();
  }
}
