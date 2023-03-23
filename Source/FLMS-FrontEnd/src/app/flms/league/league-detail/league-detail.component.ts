import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { LeagueDetail, LeagueListbyUser } from 'src/app/models/league-detail.model';
import { token } from 'src/app/models/token.model';
import { LeagueService } from '../league.service';

@Component({
  selector: 'app-league-detail',
  templateUrl: './league-detail.component.html',
  styleUrls: ['./league-detail.component.scss']
})
export class LeagueDetailComponent implements OnInit {
  leagueDetail: LeagueDetail = null;
  leagueId: number;
  private headers: HttpHeaders;
  token: token;


  constructor(
    private LeagueService: LeagueService,
    private route: ActivatedRoute,
    private router: Router,
    private http: HttpClient,
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });

    // if (this.router.getCurrentNavigation().extras.state) {
    //   this.leagueId = this.router.getCurrentNavigation().extras.state.leagueId;
    //   console.log(this.leagueId);
    // }
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.LeagueService.getLeagueInfo(this.leagueId).pipe(
      map((res: LeagueDetailResponse) => this.leagueDetail = res.leagueInfo)
    ).subscribe();
  }


}
