import { Component, OnInit } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute } from '@angular/router';
import { MatchService } from './../match.service';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { MatchDetailResponse } from 'src/app/models/match-detail-response.model';



@Component({
  selector: 'app-match-detail',
  templateUrl: './match-detail.component.html',
  styleUrls: ['./match-detail.component.scss']
})
export class MatchDetailComponent implements OnInit {
  matchDetail: MatchDetail = null;
  matchId: number;

  defaultLogo: string = './../../../../assets/image/default-logo.png';

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
    this.getMatchInfoById(this.matchId);
  }

  getMatchInfoById(matchId: number) {
    this.MatchService.getMatchInfoById(matchId).pipe(map ((res: MatchDetailResponse) => this.matchDetail = res.match)).subscribe();
  }
}
