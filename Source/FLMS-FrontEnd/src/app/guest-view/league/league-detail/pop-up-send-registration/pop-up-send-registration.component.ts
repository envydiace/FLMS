import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { PageEvent } from '@angular/material/paginator';
import { Router } from '@angular/router';
import { first, map } from 'rxjs/operators';
import { ClubService } from 'src/app/guest-view/club/club.service';
import { ClubListbyUser } from 'src/app/models/club-detail.model';

import { ClubList } from 'src/app/models/club-list.model';
import { token } from 'src/app/models/token.model';
import { LeagueService } from '../../league.service';




@Component({
  selector: 'app-pop-up-send-registration',
  templateUrl: './pop-up-send-registration.component.html',
  styleUrls: ['./pop-up-send-registration.component.scss']
})
export class PopUpSendRegistrationComponent implements OnInit {
  private headers: HttpHeaders;
  token: token;
  clubName: string = null;
  managerName: string = null;
  clubListByUser: ClubListbyUser[] = [];
  pageEvent: PageEvent;


  constructor(
    private clubService: ClubService,
    private router: Router,
    private http: HttpClient,
    public dialogRef: MatDialogRef<PopUpSendRegistrationComponent>,
    private LeagueService: LeagueService,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leagueId: number;
    }
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.clubService.findbyUserId().pipe(
      map((clubListByUser: ClubListbyUser[]) => this.clubListByUser = clubListByUser)
    ).subscribe();
  }

  sendRegistration(clubId: number): void {
    this.LeagueService.sendRegistration(this.data.leagueId, clubId)
      .pipe(first())
      .subscribe({
        next: () => {

        }
      });
  }

}
