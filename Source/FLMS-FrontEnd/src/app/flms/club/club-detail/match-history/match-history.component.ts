import { Component, OnInit } from '@angular/core';
import { ClubService } from '../../club.service';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { MatchDetail } from '../../../../models/match-detail.model';
import { ClubMatchHistoryResponse } from '../../../../models/club-match-history-response.model';

@Component({
  selector: 'app-match-history',
  templateUrl: './match-history.component.html',
  styleUrls: ['./match-history.component.scss']
})
export class MatchHistoryComponent implements OnInit {

  displayedColumns: string[] = ['League Name','Date', 'Time','Team1', 'Match','Team2','Round', 'Stadium'];
  clubId: number;
  listMatch: MatchDetail[];

  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';

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
