import { Component, Input, OnInit } from '@angular/core';
import { map } from 'rxjs/operators';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { LeagueDetail } from 'src/app/models/league-detail.model';
import { LeagueService } from '../league.service';
import { PopUpSendRegistrationComponent } from './pop-up-send-registration/pop-up-send-registration.component';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { AuthService } from 'src/app/auth/auth.service';

@Component({
  selector: 'app-league-detail',
  templateUrl: './league-detail.component.html',
  styleUrls: ['./league-detail.component.scss']
})
export class LeagueDetailComponent implements OnInit {
  leagueDetail: LeagueDetail = null;
  leagueId: number;
  role: string;
  defaultLogo: string = './../../../../assets/image/default-logo.png';

  constructor(
    private LeagueService: LeagueService,
    private route: ActivatedRoute,
    public dialog: MatDialog,
    public authen: AuthService,
  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
    this.role = this.authen.getUserRole();
  }

  initDataSource() {
    this.LeagueService.getLeagueInfo(this.leagueId).pipe(
      map((res: LeagueDetailResponse) => this.leagueDetail = res.leagueInfo)
    ).subscribe();
  }


  openSendRegistation(): void {
    const dialogRef = this.dialog.open(PopUpSendRegistrationComponent, {
      width: '100%',
      data: { leagueId: this.leagueId }
    });

    dialogRef.afterClosed().subscribe(result => {
      
    });
  }

  downloadFileRule(): void {
    const url = this.leagueDetail.rules;

    const xhr = new XMLHttpRequest();
    xhr.responseType = 'blob';
    xhr.onload = () => {
      const blob = xhr.response;
      const a = document.createElement('a');
      const objectUrl = URL.createObjectURL(blob);
      a.href = objectUrl;
      a.download = this.leagueDetail.leagueName + '-Rules.pdf';
      a.click();
      URL.revokeObjectURL(objectUrl);
    };
    xhr.open('GET', url);
    xhr.send();
  }
}
