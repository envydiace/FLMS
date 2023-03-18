import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { LeagueService } from 'src/app/flms/league/league.service';
import { LeagueListbyUser } from 'src/app/models/league-detail.model';
import { token } from '../../../models/token.model';

@Component({
  selector: 'app-league-list',
  templateUrl: './league-list.component.html',
  styleUrls: ['./league-list.component.scss']
})
export class LeagueListComponent implements OnInit {
  private headers: HttpHeaders;
  token: token;
  leagueListByUser: LeagueListbyUser[] = [];
  defaultLogo: string = './../../../../assets/image/default-logo.png';

  constructor(
    private leagueService: LeagueService,
    private router: Router,
    private http: HttpClient,

  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers  = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

   }

  ngOnInit(): void {
    this.initDataSource();

  }


  initDataSource() {
    this.leagueService.getListLeagueByUser().pipe(
      map((leagueListByUser: LeagueListbyUser[]) => this.leagueListByUser = leagueListByUser)
    ).subscribe();
  }
  navigateToLeagueDetail(id: number) {
    this.router.navigate(['/manager/my-league-info'], { queryParams: { leagueId: id }, skipLocationChange: true });
  }
}
