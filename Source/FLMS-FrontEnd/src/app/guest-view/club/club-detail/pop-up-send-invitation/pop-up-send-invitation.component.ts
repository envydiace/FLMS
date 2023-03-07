import { Component, Inject, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { PageEvent } from '@angular/material/paginator';
import { Router } from '@angular/router';
import { first, map } from 'rxjs/operators';
import { token } from 'src/app/models/token.model';
import { LeagueListbyUser } from 'src/app/models/league-detail.model';
import { LeagueService } from 'src/app/guest-view/league/league.service';
import { PopUpSendRegistrationComponent } from 'src/app/guest-view/league/league-detail/pop-up-send-registration/pop-up-send-registration.component';
import { ClubService } from '../../club.service';
import {
  MatSnackBar,
  MatSnackBarHorizontalPosition,
  MatSnackBarVerticalPosition,
} from '@angular/material/snack-bar';



@Component({
  selector: 'app-pop-up-send-invitation',
  templateUrl: './pop-up-send-invitation.component.html',
  styleUrls: ['./pop-up-send-invitation.component.scss']
})
export class PopUpSendInvitationComponent implements OnInit {

  private headers: HttpHeaders;
  token: token;
  leagueName: string = null;
  startDate: string = null;
  endDate: string = null;
  leagueListByUser: LeagueListbyUser[] = [];
  pageEvent: PageEvent;

  constructor(
    private leagueService: LeagueService,
    private router: Router,
    private http: HttpClient,
    public dialogRef: MatDialogRef<PopUpSendInvitationComponent>,
    private clubService: ClubService,
    private _snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      clubId: number;
    }
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

  }

  ngOnInit(): void {
    this.initDataSource();
  }
  initDataSource() {
    this.leagueService.findbyUserId().pipe(
      map((leagueListByUser: LeagueListbyUser[]) => this.leagueListByUser = leagueListByUser)
    ).subscribe();
  }
  sendInvitation(leagueId: number): void {
    this.clubService.sendInvitation(leagueId, this.data.clubId)
      .pipe(first())
      .subscribe({
        next: () => {
          this.openSnackBar();
        }
      });
  }

  openSnackBar() {
    this._snackBar.open('Success!!', 'CLOSE', {
      duration: 3500,
      horizontalPosition: 'center',
      verticalPosition: 'bottom',
    });
  }

}
