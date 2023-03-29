import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { ClubMatchHistoryResponse } from '../../../../models/club-match-history-response.model';
import { MatchDetail } from '../../../../models/match-detail.model';
import { ClubService } from '../../club.service';
@Component({
  selector: 'app-match-history',
  templateUrl: './match-history.component.html',
  styleUrls: ['./match-history.component.scss']
})
export class MatchHistoryComponent implements OnInit {
  displayedColumns: string[] = ['Date', 'Time','Team1', 'Match','Team2', 'Stadium'];
  clubId: number;
  listMatch: MatchDetail[];
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private ClubService: ClubService,
  ) {
    this.route.queryParams.subscribe(params => {
      this.clubId = params['clubId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.getClubMatchHistory();
  }

  getClubMatchHistory() {
    this.ClubService.getClubMatchHistory(this.clubId).pipe(
      map((res: ClubMatchHistoryResponse) => this.listMatch = res.listMatch
      )
    ).subscribe();
  }

}
