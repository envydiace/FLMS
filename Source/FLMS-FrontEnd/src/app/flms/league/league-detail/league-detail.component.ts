import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { LeagueDetail, LeagueListbyUser } from 'src/app/models/league-detail.model';
import { token } from 'src/app/models/token.model';
import { MatDialog } from '@angular/material/dialog';
import { LeagueService } from '../league.service';
import { PopupDeleteLeagueComponent } from '../popup-delete-league/popup-delete-league.component';
import { PopUpEditLeagueComponent } from '../pop-up-edit-league/pop-up-edit-league.component';
import { AuthService } from 'src/app/auth/auth.service';
import { PopUpUploadRulesComponent } from './pop-up-upload-rules/pop-up-upload-rules.component';

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
  // defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  defaultLogo: string = './../../../../assets/image/default-logo.png';
  userRole: any;


  constructor(
    private LeagueService: LeagueService,
    private route: ActivatedRoute,
    private router: Router,
    private http: HttpClient,
    public dialog: MatDialog,
    public authen: AuthService,
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
    this.userRole = this.authen.getUserRole();

    this.initDataSource();
  }

  initDataSource() {
    if (this.userRole == 'LEAGUE_MANAGER') {
      this.LeagueService.getLeagueInfo(this.leagueId).pipe(
        map((res: LeagueDetailResponse) => this.leagueDetail = res.leagueInfo)
      ).subscribe({
        next: response => {
        },
        error: error => {
          this.router.navigate(['/not-found']);
        }
      });
    } else {
      this.LeagueService.getLeagueInfoRoleClub(this.leagueId).pipe(
        map((res: LeagueDetailResponse) => this.leagueDetail = res.leagueInfo)
      ).subscribe();
    }
  }

  openDeleteLeaguePopup(leagueId: number): void {
    const dialogRef = this.dialog.open(PopupDeleteLeagueComponent, {
      width: '50%',
      data: { leagueId: this.leagueId }
    });
    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }

  openEditLeague(leagueId: number): void {
    const dialogRef = this.dialog.open(PopUpEditLeagueComponent, {
      width: '80%',
      data: { leagueId: this.leagueId },
      disableClose: true
    });
    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      console.log('The dialog was closed');
    });
  }

  openUploadRule(): void {
    const dialogRef = this.dialog.open(PopUpUploadRulesComponent, {
      width: '30%',
      data: {
        leagueId: this.leagueId,
        leagueName: this.leagueDetail.leagueName,
        leagueLogo: this.leagueDetail.logo
      },
    });
    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      console.log('The dialog was closed');
    });
  }
}
