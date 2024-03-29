import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { NavigationExtras, Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { LeagueDetail, LeagueListbyUser } from 'src/app/models/league-detail.model';
import { token } from 'src/app/models/token.model';
import { LeagueService } from '../../league/league.service';

@Component({
  selector: 'app-joined-league',
  templateUrl: './joined-league.component.html',
  styleUrls: ['./joined-league.component.scss']
})
export class JoinedLeagueComponent implements OnInit {
  private headers: HttpHeaders;
  token: token;
  leagueListByUser: LeagueListbyUser[] = [];
  defaultLogo: string = './../../../../assets/image/default-logo.png';

  constructor(
    private leagueService: LeagueService,
    private router: Router,
    private http: HttpClient
  ) { 
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers  = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.leagueService.getJoinedLeagueByUser().pipe(
      map((leagueListByUser: LeagueDetail[]) => this.leagueListByUser = leagueListByUser)
    ).subscribe();
  }

  navigateToLeagueDetail(id: number) {
    let navigationExtras: NavigationExtras = {
      state: {
        leagueId: id
      }
    }
    this.router.navigate(['/manager/my-league-info'], { queryParams: { leagueId: id } });
    // this.router.navigate(['/manager/my-league-info'], navigationExtras);
  }
}
