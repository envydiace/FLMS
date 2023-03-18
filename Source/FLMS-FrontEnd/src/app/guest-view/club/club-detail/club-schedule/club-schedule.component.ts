import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ClubMatchSchedule } from 'src/app/models/match-schedule.model';
import { ClubService } from '../../club.service';
import { map, tap } from 'rxjs/operators';
import { ClubMatchScheduleResponse } from 'src/app/models/match-schedule-response.model';

@Component({
  selector: 'app-club-schedule',
  templateUrl: './club-schedule.component.html',
  styleUrls: ['./club-schedule.component.scss']
})
export class ClubScheduleComponent implements OnInit {

  displayedColumns: string[] = ['matchDate', 'matchTime', 'against', 'stadium', 'ha'];
  clubId: number;
  listMatch: ClubMatchSchedule[] = []

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
